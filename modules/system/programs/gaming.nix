{
  pkgs,
  lib,
  config,
  username,
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
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };
    hardware.steam-hardware.enable = lib.mkForce false;

    environment.systemPackages = with pkgs; [
      # bottles
      mangohud
      lutris
      steam-run
      winetricks
      wineWowPackages.stable
      cabextract
      vkbasalt
    ];

    programs.obs-studio.enable = true;
    services.hardware.openrgb.enable = true;

    programs.gamemode = {
      enable = true;
      # LACT handles gpu stuff
      settings = {
        general = {
          reaper_freq = 5;
          desiredgov = "performance";
          desiredprof = "performance";
          softrealtime = "auto";
          renice = 10;
          ioprio = 0;
          inhibit_screensaver = 1;
          disable_splitlock = 1;
        };
        custom = {
          start = "${pkgs.libnotify}/bin/notify-send -t 2000 'GameMode started'; pkill codium; pkill ktorrent";
          end = "${pkgs.libnotify}/bin/notify-send -t 2000 'GameMode ended'";
          script_timeout = 10;
        };
      };
    };

    users.users.${username}.extraGroups = ["gamemode"];

    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
      PROTON_ENABLE_WAYLAND = 1;
    };

    # Might need to sudo chmod 777 ~/.steam , for protontricks to work
  };
}
