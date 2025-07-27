{
  inputs,
  pkgs,
  username,
  ...
}: {
  programs = {
    fish.enable = true;
    zsh.enable = true;
    hyprland = {
      enable = true;
      withUWSM = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      xwayland.enable = false;
      systemd.setPath.enable = true; # Not sure if needed
    };
    dconf.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    nix-ld.enable = true;
  };

  environment = {
    variables = {
      FLAKE = "/home/${username}/dotfiles";
      SHELL = "/etc/profiles/per-user/${username}/bin/fish";
      NIXOS_OZONE_WL = "1";
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

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
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

  # For polkit authentication
  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = ["graphical-session.target"];
    wants = ["graphical-session.target"];
    after = ["graphical-session.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
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
