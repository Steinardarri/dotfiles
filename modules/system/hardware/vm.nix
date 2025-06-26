{
  lib,
  hostname,
  ...
}: let
  inherit (import ../../../hosts/${hostname}/options.nix) cpuType;
in
  lib.mkIf ("${cpuType}" == "vm") {
    services.qemuGuest.enable = true;
    services.spice-vdagentd.enable = true;
    services.spice-webdavd.enable = true;
  }
