{inputs, ...}: {
  imports = [
    inputs.nix-index-database.homeModules.nix-index

    ./bash.nix
    ./zsh.nix
    ./fish
    ./starship.nix
  ];
}
