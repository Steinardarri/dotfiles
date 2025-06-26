{
  lib,
  pkgs,
  hostname,
  ...
}: let
  inherit (import ../../../hosts/${hostname}/options.nix) theKernel;
in
  lib.mkIf (theKernel == "xanmod") {
    boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  }
