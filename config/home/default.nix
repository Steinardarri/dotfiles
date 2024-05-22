{...}: {
  imports = [
    # Enable &/ Configure Programs
    ./alacritty.nix
    ./bash.nix
    ./helix.nix
    ./kitty.nix
    ./packages.nix
    ./personal.nix
    ./starship.nix
    ./vscodium.nix
    ./zsh.nix

    # Place Home Files Like Pictures
    ./files.nix
  ];
}
