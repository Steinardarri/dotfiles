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
    environment.sessionVariables = {
      MOZ_USE_XINPUT2 = "1";
    };
    xdg = {
      portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-wlr
          xdg-desktop-portal-gtk
        ];
      };
    };
  }
