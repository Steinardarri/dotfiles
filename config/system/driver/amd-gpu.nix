{
  pkgs,
  lib,
  hostname,
  ...
}: let
  inherit (import ../../../hosts/${hostname}/options.nix) gpuType;
in
  lib.mkIf ("${gpuType}" == "amd") {
    systemd.tmpfiles.rules = [
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];
  }
