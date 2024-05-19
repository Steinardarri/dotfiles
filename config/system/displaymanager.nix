{
  pkgs,
  config,
  hostname,
  ...
}: let
  inherit
    (import ../../hosts/${hostname}/options.nix)
    theKBDVariant
    theKBDLayout
    theSecondKBDLayout
    ;
in {
  services = {
    xserver = {
      enable = true;
      xkb = {
        variant = "${theKBDVariant}";
        layout = "${theKBDLayout}, ${theSecondKBDLayout}";
      };
    };
    displayManager.sddm = {
      enable = true;
      autoNumlock = true;
      wayland.enable = true;
      theme = "tokyo-night-sddm";
    };
    libinput.enable = true;
  };

  environment.systemPackages = let
    sugar = pkgs.callPackage ../pkgs/sddm-sugar-dark.nix {};
    tokyo-night = pkgs.libsForQt5.callPackage ../pkgs/sddm-tokyo-night.nix {};
  in [
    sugar.sddm-sugar-dark # Name: sugar-dark
    tokyo-night # Name: tokyo-night-sddm
    pkgs.libsForQt5.qt5.qtgraphicaleffects
  ];
}
