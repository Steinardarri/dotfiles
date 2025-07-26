{...}: {
  imports = [
    ./drivers
    ./programs
    ./services

    ./audio.nix
    ./boot.nix
    ./locale.nix
    ./nix.nix
    ./packages.nix
    ./system.nix
  ];

  time.timeZone = "Atlantic/Reykjavik";

  system.stateVersion = "25.05";
}
