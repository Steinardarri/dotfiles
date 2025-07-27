{inputs, ...}: {
  imports = [
    inputs.nix-index-database.homeModules.nix-index

    ./fish

    ./starship.nix
    ./zsh.nix
  ];
}
