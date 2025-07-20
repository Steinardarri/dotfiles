{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    _gaming.enable = lib.mkEnableOption "User-Defined Gaming Module";
  };

  config = lib.mkIf config._gaming.enable {
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      protontricks.enable = true;
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
      cabextract
      protonup-qt
    ];

    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };

    # Might need to sudo chmod 777 ~/.steam , for protontricks to work
  };
}
