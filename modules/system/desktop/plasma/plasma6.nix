{
  pkgs,
  username,
  ...
}: {
  services = {
    desktopManager.plasma6 = {
      enable = true;
      enableQt5Integration = false;
    };

    displayManager = {
      sddm = {
        enable = true;
        wayland = {
          enable = true;
        };
        settings = {
          Autologin = {
            Session = "plasma.desktop";
            User = "${username}";
          };
        };
        autoNumlock = true;
        setupScript = ''${pkgs.numlockx}/bin/numlockx on '';
      };
    };
  };

  environment.systemPackages = with pkgs; [
    gtk2
    gtk3
    gtk4

    wayland-utils
    xwaylandvideobridge
    kdePackages.kwayland
    kdePackages.wayqt
    wl-clipboard

    # Development
    kdePackages.kate

    # Graphics
    krita
    kdePackages.kdenlive
    glaxnimate

    # Internet
    kdePackages.kmail
    kdePackages.krdc
    kdePackages.krfb

    # Multimedia
    kdePackages.arianna
    haruna

    # Office
    # Uses the depricated and unsafe qtwebkit-5 package
    # which makes the build fail
    # calligra

    # System
    kdePackages.ksystemlog

    # Utilities
    kwalletcli
    kdePackages.kcalc
    kdePackages.filelight
  ];

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    print-manager
  ];

  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_USE_XINPUT2 = "1";
    NIXOS_OZONE_WL = "1"; # for Electron & Chromium apps
  };

  programs.kdeconnect.enable = true;
  programs.partition-manager.enable = true;
}
