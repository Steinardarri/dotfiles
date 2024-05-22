{
  lib,
  hostname,
  ...
}: let
  inherit (import ../../hosts/${hostname}/options.nix) browser;
in
  lib.mkIf (browser != "floorp") {
    programs."${browser}" = {
      enable = true;
    };
  }
