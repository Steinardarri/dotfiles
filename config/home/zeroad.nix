{
  pkgs,
  config,
  lib,
  hostname,
  ...
}: let
  inherit (import ../../hosts/${hostname}/options.nix) enableZeroAD;
in
  lib.mkIf (enableZeroAD == true) {
    home.packages = with pkgs; [
      zeroad
    ];
  }
