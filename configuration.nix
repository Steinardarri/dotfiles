{
  hostname,
  username,
  inputs,
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
    terminal
    ;
in {
  imports = [
    ./hosts/${hostname}/hardware.nix
    ./config/system
    ./config/stylix
    ./users/users.nix
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
    EDITOR = "hx";
    LANG = "${theLocale}";
    SHELL = "/etc/profiles/per-user/${username}/bin/${theShell}";
    TERM = "${terminal}";
  };

  nixpkgs = {
    overlays = [
      inputs.nur.overlay
    ];
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

  system.stateVersion = "23.11";
}
