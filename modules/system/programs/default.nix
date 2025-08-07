{...}: {
  imports = [
    ./gaming.nix
    ./nano.nix
    ./thunar.nix
  ];

  programs = {
    partition-manager.enable = true;
  };
}
