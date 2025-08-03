{
  inputs,
  pkgs,
  username,
  ...
}: let
  hypr-pkgs = inputs.hyprland.packages.${pkgs.system};
in {
  imports = [
    inputs.hyprland.nixosModules.default
  ];

  programs = {
    fish = {
      enable = true;
      useBabelfish = true;
    };
    zsh.enable = true;
    # https://wiki.hypr.land/Nix/Hyprland-on-NixOS/
    hyprland = {
      enable = true;
      withUWSM = true;
      package = hypr-pkgs.hyprland;
      portalPackage = hypr-pkgs.xdg-desktop-portal-hyprland;
      # Disable XWayland when Steam finally gets a 64 bit wayland client
      xwayland.enable = true;
      systemd.setPath.enable = true;
    };
    dconf.enable = true;
    nix-ld.enable = true;
  };

  services.xserver = {
    enable = false;
    videoDrivers = ["amdgpu"];
  };

  environment = {
    variables = {
      FLAKE = "/home/${username}/dotfiles";

      # Wayland support for Electron apps
      NIXOS_OZONE_WL = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";

      SDL_VIDEODRIVER = "wayland"; # Run SDL2 applications on Wayland. Remove or set to x11 if games that provide older versions of SDL cause compatibility issues
      CLUTTER_BACKEND = "wayland"; # Clutter package already has wayland enabled, this variable will force Clutter applications to try and use the Wayland backend

      PAGER = "bat";
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

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    config = {
      common.default = ["gtk"];
      hyprland.default = [
        "gtk"
        "hyprland"
      ];
    };

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
