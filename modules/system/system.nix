{
  pkgs,
  username,
  ...
}: {
  programs = {
    nh = {
      enable = true;
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep-since 14d --keep 10";
      };
      flake = "/home/${username}/dotfiles";
    };
    fish.enable = true;
    hyprland = {
      enable = true;
      withUWSM = false;
    };
    dconf.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    nix-ld.enable = true;
  };

  environment.pathsToLink = [
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

  # For polkit authentication
  security.polkit.enable = true;
  security.pam.services.swaylock = {};
  security.rtkit.enable = true;
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
