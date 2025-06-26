{
  lib,
  pkgs,
  hostname,
  ...
}: let
  inherit (import ../../../hosts/${hostname}/options.nix) theKernel;
in
  lib.mkIf (theKernel == "zen") {
    boot.kernelPackages = pkgs.linuxPackages_zen;
  }
