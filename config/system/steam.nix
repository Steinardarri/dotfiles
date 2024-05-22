{
  lib,
  hostname,
  pkgs,
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
    environment.systemPackages = with pkgs; [
      steam-run
      winetricks
      protontricks
    ];
  }
