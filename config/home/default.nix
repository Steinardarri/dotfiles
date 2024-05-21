{...}: {
  imports = [
    # Enable &/ Configure Programs
    ./alacritty.nix
    ./bash.nix
    ./cursor.nix
    ./helix.nix
    ./kdenlive.nix
    ./kitty.nix
    # ./neofetch.nix
    ./packages.nix
    ./starship.nix
    ./vscodium.nix
    ./zsh.nix

    # Place Home Files Like Pictures
    ./files.nix
  ];
}
