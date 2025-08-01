{
  inputs,
  pkgs,
  lib,
  username,
  ...
}: {
  imports = [
    inputs.hyprland.nixosModules.default
  ];

  programs = {
    fish.enable = true;
    zsh.enable = true;
    # https://wiki.hypr.land/Nix/Hyprland-on-NixOS/
    hyprland = {
      enable = true;
      withUWSM = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      # Disable XWayland when Steam finally gets a 64 bit wayland client
      xwayland.enable = true;
      systemd.setPath.enable = true;
    };
    dconf.enable = true;
    nix-ld.enable = true;
  };

  environment = {
    variables = {
      FLAKE = "/home/${username}/dotfiles";
      SHELL = "/etc/profiles/per-user/${username}/bin/fish";

      # Wayland support for Electron apps
      NIXOS_OZONE_WL = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";

      SDL_VIDEODRIVER = "wayland"; # Run SDL2 applications on Wayland. Remove or set to x11 if games that provide older versions of SDL cause compatibility issues
      CLUTTER_BACKEND = "wayland"; # Clutter package already has wayland enabled, this variable will force Clutter applications to try and use the Wayland backend
    };

    pathsToLink = [
      "/share/icons"
      "/share/themes"
      "/share/fonts"
      "/share/xdg-desktop-portal"
      "/share/applications"
      "/share/mime"
      "/share/wayland-sessions"
      "/share/zsh"
      "/share/bash-completion"
      "/share/fish"
    ];
  };

  # Security
  security = {
    sudo-rs = {
      enable = true;
      execWheelOnly = true;
    };

    # Extra security
    protectKernelImage = true;

    # For polkit authentication
    polkit.enable = true;
    rtkit.enable = true;
    pam.services.kwallet = {
      enable = true;
      kwallet.enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    kdePackages.kleopatra
    kdePackages.kwallet
    kdePackages.kwalletmanager
    kdePackages.ksshaskpass
    pinentry-qt
    gnupg
  ];
  environment.variables = {
    PINENTRY = "pinentry-qt";
    SSH_ASKPASS = lib.mkForce "/run/current-system/sw/bin/ksshaskpass";
    SSH_ASKPASS_REQUIRE = "prefer";
  };

  services = {
    dbus.enable = true;
    upower.enable = true;
    openssh.enable = true;
    libinput.enable = true;
    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
  };

  fonts = {
    packages = with pkgs; [
      nerd-fonts.hack
    ];
    fontDir.enable = true;
  };

  # For proper XDG desktop integration
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  # Regist appimage-run as the executor of appimages
  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };
}
