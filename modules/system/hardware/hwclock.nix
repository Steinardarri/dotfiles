{
  lib,
  hostname,
  ...
}: let
  inherit (import ../../../hosts/${hostname}/options.nix) localHWClock;
in
  lib.mkIf (localHWClock == true) {
    time.hardwareClockInLocalTime = true;
  }
