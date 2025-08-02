{inputs, ...}: {
  imports = [
    inputs.nix-index-database.homeModules.nix-index

    ./fish
    ./fastfetch

    ./starship.nix
    ./zsh.nix
  ];
}
