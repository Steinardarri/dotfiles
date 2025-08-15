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
        package = pkgs.steam.override {
          extraPkgs = pkgs:
            with pkgs; [
              libkrb5
              keyutils
            ];
        };
        gamescopeSession.enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
        protontricks.enable = true;
        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
      };
      obs-studio.enable = true;
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
            start = "${pkgs.libnotify}/bin/notify-send -t 2000 'GameMode started' ; pkill codium ; pkill ktorrent";
            end = "${pkgs.libnotify}/bin/notify-send -t 2000 'GameMode ended'";
            script_timeout = 10;
          };
        };
      };
      zsh = {
        loginShellInit = lib.mkBefore ''
          # For gamescope
          sudo chown -R ${username} /tmp/.X11-unix

          ${lib.optionalString config._rgb.enable ''
            openrgb -P Orange
          ''}
        '';
      };
    };
    hardware.steam-hardware.enable = lib.mkForce false;

    environment.systemPackages = with pkgs; [
      mangohud
      lutris
      steam-run
      winetricks
      wineWowPackages.unstableFull
      cabextract
      vkbasalt
    ];

    services.hardware.openrgb.enable = config._rgb.enable;

    users.users.${username}.extraGroups = ["gamemode"];

    environment.sessionVariables = {
      # PROTON_ENABLE_WAYLAND = 1;
      WINEDEBUG = "-all";
    };

    # Might need to sudo chmod 777 ~/.steam , for protontricks to work
  };
}
