{
  pkgs,
  lib,
  hostname,
  ...
}: let
  inherit
    (import ../../hosts/${hostname}/options.nix)
    username
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
      desktopManager.plasma5.enable = lib.mkDefault true;
    };

    displayManager = {
      sddm = {
        enable = true;
        autoNumlock = true;
      };
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
        disableWhileTyping = true;
      };
    };
  };
  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    oxygen
  ];
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };
}
