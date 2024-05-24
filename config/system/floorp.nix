{
  pkgs,
  lib,
  hostname,
  ...
}: let
  inherit (import ../../hosts/${hostname}/options.nix) browser;
in
  lib.mkIf (browser == "floorp") {
    # Builds Floorp from source, with unfree stuff
    programs.firefox = {
      enable = true;
      package = pkgs.floorp;
    };
    xdg = {
      portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal
          xdg-desktop-portal-kde
          xdg-desktop-portal-gtk
        ];
      };
    };
  }
