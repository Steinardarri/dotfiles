{
  pkgs,
  lib,
  hostname,
  ...
}: let
  inherit
    (import ../../hosts/${hostname}/options.nix)
    personal
    ;
in
  lib.mkIf (personal == true) {
    home.packages = with pkgs; [
      discord

      protonvpn-gui
      protonmail-bridge-gui
      #protonmail-bridge

      kdePackages.kpat
      kdePackages.ktorrent
      kdePackages.kdenlive
    ];
  }
