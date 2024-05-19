{
  config,
  lib,
  pkgs,
  hostname,
  ...
}: let
  inherit (import ../../../hosts/${hostname}/options.nix) theKernel;
in
  lib.mkIf (theKernel == "lqx") {
    boot.kernelPackages = pkgs.linuxPackages_lqx;
  }
