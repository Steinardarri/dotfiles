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
    nixpkgs.config.packageOverrides = pkgs: {
      steam = pkgs.steam.override {
        extraLibraries = pkgs: [ pkgs.xorg.libxcb ];
        extraPkgs = pkgs:
          with pkgs; [
            xorg.libXcursor
            xorg.libXi
            xorg.libXinerama
            xorg.libXScrnSaver
            libpng
            libpulseaudio
            libvorbis
            stdenv.cc.cc.lib
            libkrb5
            keyutils
          ];
      };
    };
    programs = {
      steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
        protontricks.enable = true;
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
            start = "${pkgs.libnotify}/bin/notify-send -t 2000 'GameMode started' ; pkill codium ; pkill ktorrent";
            end = "${pkgs.libnotify}/bin/notify-send -t 2000 'GameMode ended'";
            script_timeout = 10;
          };
        };
      };
      zsh = {
        loginShellInit = lib.mkAfter ''
          # For gamescope
          sudo chown -R ${username} /tmp/.X11-unix

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
      steam-run
      winetricks
      wineWowPackages.staging
      cabextract
    ];

    services.hardware.openrgb.enable = config._rgb.enable;

    # Might need to sudo chmod 777 ~/.steam , for protontricks to work
  };
}
