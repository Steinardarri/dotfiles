{
  hostname,
  username,
  ...
}: let
  inherit
    (import ./hosts/${hostname}/options.nix)
    theLocale
    theTimezone
    theLCVariables
    theConsoleKeyMap
    flakeDir
    theShell
    ;
in {
  imports = [
    ./hosts/${hostname}/hardware-configuration.nix
    ./modules/system
    ./users/${username}
  ];

  networking.hostName = "${hostname}";
  networking.networkmanager.enable = true;

  time.timeZone = "${theTimezone}";

  i18n.defaultLocale = "${theLocale}";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "${theLCVariables}";
    LC_IDENTIFICATION = "${theLCVariables}";
    LC_MEASUREMENT = "${theLCVariables}";
    LC_MONETARY = "${theLCVariables}";
    LC_NAME = "${theLCVariables}";
    LC_NUMERIC = "${theLCVariables}";
    LC_PAPER = "${theLCVariables}";
    LC_TELEPHONE = "${theLCVariables}";
    LC_TIME = "${theLCVariables}";
  };
  console.keyMap = "${theConsoleKeyMap}";

  environment.variables = {
    FLAKE = "${flakeDir}";
    LANG = "${theLocale}";
    SHELL = "/etc/profiles/per-user/${username}/bin/${theShell}";
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
    };
  };

  # Optimization settings and garbage collection automation
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };
  };
  programs = {
    nh = {
      enable = true;
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep-since 14d --keep 15";
      };
    };
  };

  system.stateVersion = "25.05";
}
