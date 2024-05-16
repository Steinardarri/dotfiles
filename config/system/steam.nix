{
  pkgs,
  config,
  lib,
  host,
  ...
}: let
  inherit (import ../../hosts/${host}/options.nix) steam;
in
  lib.mkIf (steam == true) {
    # Steam Configuration
    programs.steam = {
      gamescopeSession.enable = true;
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
  }
