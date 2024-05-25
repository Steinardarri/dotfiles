{
  lib,
  hostname,
  pkgs,
  ...
}: let
  inherit (import ../../hosts/${hostname}/options.nix) gaming;
in
  lib.mkIf (gaming == true) {

    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    programs.gamescope.enable = true;
    hardware.steam-hardware.enable = true;

    programs.gamemode.enable = true;

    environment.systemPackages = with pkgs; [
      bottles
      mangohud
      lutris
      steam-run
      winetricks
      wineWowPackages.stable
      protontricks
      protonup-qt
    ];

    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };
  }
