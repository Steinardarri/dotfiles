{...}: {
  imports = [
    ./gaming.nix
    ./nano.nix
  ];

  programs = {
    partition-manager.enable = true;
  };
}
