{pkgs, ...}: {
  services = {
    desktopManager.plasma6.enable = true;

    displayManager = {
      sddm = {
        enable = true;
        package = pkgs.kdePackages.sddm;
        autoNumlock = true;
        wayland = {
          enable = true;
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

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    oxygen
  ];

  environment.systemPackages = with pkgs; [
    wayland-utils
    xwayland
    xwaylandvideobridge
    kdePackages.kwayland
    kdePackages.wayqt
    wl-clipboard

    kdePackages.kate
    kdePackages.kcalc
    kdePackages.filelight
    kdePackages.ksystemlog
    kdePackages.partitionmanager
  ];

  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_USE_XINPUT2 = "1";
    NIXOS_OZONE_WL = "1"; # for VSCode Discord etc
  };
}
