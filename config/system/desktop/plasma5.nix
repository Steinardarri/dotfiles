{pkgs, ...}: {
  services = {
    xserver.desktopManager.plasma5.enable = true;

    displayManager = {
      sddm = {
        enable = true;
        package = pkgs.libsForQt5.sddm;
        autoNumlock = true;
        wayland = {
          enable = false;
          compositor = "kwin";
        };
        settings = {
          Autologin = {
            Session = "plasma.desktop";
            User = "steinardth";
          };
        };
      };
    };
  };

  environment.systemPackages = with pkgs; [
    gtk2
    gtk3
    gtk4

    # Development
    libsForQt5.kate

    # Graphics
    krita

    # Internet
    libsForQt5.kmail
    libsForQt5.krdc
    libsForQt5.krfb

    # Multimedia
    libsForQt5.arianna
    libsForQt5.kdenlive

    # Office
    # Uses the depricated and unsafe qtwebkit-5 package
    # which makes the build fail
    # calligra

    # System
    libsForQt5.ksystemlog

    # Utilities
    libsForQt5.kaccounts-providers
    libsForQt5.filelight
    libsForQt5.kcalc
  ];

  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    oxygen
  ];

  programs.kdeconnect.enable = true;
  programs.partition-manager.enable = true;

  security.pam.services.ssdm.enableKwallet = true;
  security.pam.services.ssdm.gnupg.enable = true;
}
