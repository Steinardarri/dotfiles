{
  config,
  lib,
  pkgs,
  hostname,
  ...
}: let
  inherit (import ../../../hosts/${hostname}/options.nix) theKernel;
in
  lib.mkIf (theKernel == "default") {
    boot.kernelPackages = pkgs.linuxPackages;
  }
