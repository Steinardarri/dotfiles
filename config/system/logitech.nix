{
  pkgs,
  config,
  lib,
  hostname,
  ...
}: let
  inherit (import ../../hosts/${hostname}/options.nix) logitech;
in
  lib.mkIf (logitech == true) {
    hardware.logitech.wireless.enable = true;
    hardware.logitech.wireless.enableGraphical = true;
  }
