{
  lib,
  pkgs,
  hostname,
  ...
}: let
  inherit (import ../../../hosts/${hostname}/options.nix) theKernel;
in
  lib.mkIf (theKernel == "latest") {
    boot.kernelPackages = pkgs.linuxPackages_latest;
  }
