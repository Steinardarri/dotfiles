{
  pkgs,
  lib,
  hostname,
  ...
}: let
  inherit
    (import ../../hosts/${hostname}/options.nix)
    work
    ;
in
  lib.mkIf (work == false) {
    home.packages = with pkgs; [
      discord

      protonvpn-gui
      protonmail-bridge-gui
      #protonmail-bridge

      kdePackages.kpat
      kdePackages.ktorrent
    ];
  }
