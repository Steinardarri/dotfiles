{inputs, ...}: {
  imports = [
    inputs.nix-index-database.homeModules.nix-index

    ./fish

    ./fastfetch.nix
    ./starship.nix
    ./zsh.nix
  ];
}
