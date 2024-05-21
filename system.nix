{
  pkgs,
  hostname,
  ...
}: let
  inherit
    (import ./hosts/${hostname}/options.nix)
    username
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
    ./users/users.nix
  ];

  # Enable networking
  networking.hostName = "${hostname}"; # Define your hostname
  networking.networkmanager.enable = true;

  # Set your time zone
  time.timeZone = "${theTimezone}";

  # Select internationalisation properties
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

  # Define a user account.
  users = {
    mutableUsers = true;
  };

  environment.variables = {
    FLAKE = "${flakeDir}";
    EDITOR = "hx";
    LANG = "${theLocale}";
    SHELL = "/etc/profiles/per-user/${username}/bin/${theShell}";
    TERM = "${terminal}";
  };

  # Optimization settings and garbage collection automation
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = ["nix-command" "flakes"];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  system.stateVersion = "23.11";
}
