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
      krita
      protonvpn-gui
      kdePackages.kpat
      kdePackages.ktorrent
      kdePackages.kdenlive
    ];
  }
