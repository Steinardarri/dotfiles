{
  pkgs,
  hostname,
  username,
  ...
}: let
  inherit
    (import ../../../hosts/${hostname}/options.nix)
    theKBDVariant
    theKBDLayout
    theSecondKBDLayout
    ;
in {
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "${theKBDLayout}, ${theSecondKBDLayout}";
        variant = "${theKBDVariant}";
      };
    };

    desktopManager.plasma6.enable = true;

    displayManager.sddm = {
      enable = true;
      autoNumlock = true;
      wayland.enable = true;
      settings.Wayland.SessionDir = "${pkgs.plasma5Packages.plasma-workspace}/share/wayland-sessions";
      autoLogin.enable = true;
      autoLogin.user = "${username}";
    };

    libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
      };
      touchpad = {
        # accelProfile = "flat";
        naturalScrolling = true;
        disableWhileTyping = false;
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

    kdePackages.breeze-gtk
    kdePackages.kde-gtk-config
    xdg-desktop-portal
    kdePackages.xdg-desktop-portal-kde

    kdePackages.kate
    kdePackages.kcalc
    kdePackages.filelight
    kdePackages.ksystemlog
    kdePackages.spectacle
  ];

  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_USE_XINPUT2 = "1";
    NIXOS_OZONE_WL = "1"; # for VSCode Discord etc
  };
}
