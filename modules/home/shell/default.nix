{inputs, ...}: {
  imports = [
    inputs.nix-index-database.hmModules.nix-index

    ./bash.nix
    ./zsh
    ./fish
  ];
}
