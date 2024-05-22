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
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };

    programs.gamemode.enable = true;

    hardware.steam-hardware.enable = true;

    environment.systemPackages = with pkgs; [
      bottles
      mangohud
      lutris
      steam-run
      winetricks
      protontricks
      protonup
    ];

    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };
  }
