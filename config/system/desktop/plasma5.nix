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

    libsForQt5.kaccounts-integration
    libsForQt5.kaccounts-providers
    libsForQt5.kate
    libsForQt5.kcalc
    libsForQt5.filelight
    libsForQt5.ksystemlog
    krita
  ];

  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    oxygen
  ];

  programs.kdeconnect.enable = true;
  programs.partition-manager.enable = true;

  security.pam.services.ssdm.enableKwallet = true;
  security.pam.services.ssdm.gnupg.enable = true;
}
