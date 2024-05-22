{
  pkgs,
  lib,
  hostname,
  ...
}: let
  inherit (import ../../hosts/${hostname}/options.nix) browser;
in
  lib.mkIf (browser == "floorp") {
    programs.firefox = {
      enable = true;
      package =
        pkgs.wrapFirefox
        (pkgs.floorp-unwrapped.overrideAttrs (old: {
          configureFlags =
            (old.configureFlags or [])
            ++ [
              "--enable-private-components"
            ];
        }))
        {};
      preferences = {
        "widget.use-xdg-desktop-portal.file-picker" = 1;
        "widget.use-xdg-desktop-portal.mime-handler" = 1;
        "media.hardwaremediakeys.enabled" = false;
      };
    };
  }
