{hostname, ...}: let
  inherit
    (import ../../../hosts/${hostname}/options.nix)
    theKBDVariant
    theKBDLayout
    theSecondKBDLayout
    ;
in {
  services = {
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
