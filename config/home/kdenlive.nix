{
  pkgs,
  config,
  lib,
  hostname,
  ...
}: let
  inherit (import ../../hosts/${hostname}/options.nix) kdenlive;
in
  lib.mkIf (kdenlive == true) {
    home.packages = with pkgs; [
      pkgs.kdenlive
    ];
  }
