{
  lib,
  hostname,
  ...
}: let
  inherit (import ../../hosts/${hostname}/options.nix) steam;
in
  lib.mkIf (steam == true) {
    # Steam Configuration
    programs.steam = {
      gamescopeSession.enable = true;
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    hardware.steam-hardware.enable = true;
  }
