{
  config,
  lib,
  options,
  hostname,
  ...
}: let
  inherit (import ../../hosts/${hostname}/options.nix) ntp;
in
  lib.mkIf (ntp == true) {
    networking.timeServers = options.networking.timeServers.default ++ ["pool.ntp.org"];
  }
