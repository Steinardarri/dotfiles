{
  pkgs,
  lib,
  config,
  username,
  ...
}: {
  options = {
    _gaming.enable = lib.mkEnableOption "User-Defined Gaming Module";
    _rgb.enable = lib.mkEnableOption "User-Defined RGB Module";
  };

  config = lib.mkIf config._gaming.enable {
    programs = {
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
        protontricks.enable = false;
        extraCompatPackages = with pkgs; [
          steamtinkerlaunch
        ];
      };
      gamescope = {
        enable = true;
        capSysNice = true;
      };
      obs-studio.enable = false;
      gamemode = {
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
            start = "${pkgs.libnotify}/bin/notify-send -t 2000 'GameMode started'";
            end = "${pkgs.libnotify}/bin/notify-send -t 2000 'GameMode ended'";
            script_timeout = 3;
          };
        };
      };
      zsh = {
        loginShellInit = lib.mkAfter ''
          ${lib.optionalString config._rgb.enable ''
            openrgb -p Orange
          ''}
        '';
      };
    };
    hardware.steam-hardware.enable = lib.mkForce false;
    users.users.${username}.extraGroups = ["gamemode"];

    environment.systemPackages = with pkgs; [
      lutris
      winetricks
      wineWowPackages.unstable
      cabextract
      protonup-qt
    ];

    services.hardware.openrgb.enable = config._rgb.enable;

    environment.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "/home/${username}/.steam/root/compatibilitytools.d";
    };

    # Might need to sudo chmod 777 ~/.steam , for protontricks to work
  };
}
