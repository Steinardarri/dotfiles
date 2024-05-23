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
      desktopManager.plasma5.enable = true;
    };
    displayManager = {
      sddm.enable = true;
      autoLogin.enable = true;
      autoLogin.user = "${username}";
    };
  };
  environment.systemPackages = with pkgs; [
    libsForQt5.breeze-gtk
    libsForQt5.kde-gtk-config
    xdg-desktop-portal
    libsForQt5.xdg-desktop-portal-kde
    gtk2
    gtk3
    gtk4

    libsForQt5.kate
    libsForQt5.kcalc
    libsForQt5.filelight
    libsForQt5.ksystemlog
    libsForQt5.spectacle
    libsForQt5.partitionmanager
  ];
  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    oxygen
  ];
}
