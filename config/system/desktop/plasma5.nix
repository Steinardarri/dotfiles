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

    libsForQt5.kate
    libsForQt5.kcalc
    libsForQt5.filelight
    libsForQt5.ksystemlog
    libsForQt5.partitionmanager
  ];

  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    oxygen
  ];
}
