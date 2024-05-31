{hostname, ...}: let
  inherit
    (import ../../../hosts/${hostname}/options.nix)
    theKBDVariant
    theKBDLayout
    theSecondKBDLayout
    ;
in {
  imports = [
    # Select Desktop Environment or Tiling Compositor
    #./plasma5.nix
    ./plasma6.nix
  ];

  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "${theKBDLayout}, ${theSecondKBDLayout}";
        variant = "${theKBDVariant}";
      };
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
}
