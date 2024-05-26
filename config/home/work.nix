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
  lib.mkIf (work == true) {
    home.packages = with pkgs; [
      element-desktop
      postman
      dbeaver
    ];
  }
