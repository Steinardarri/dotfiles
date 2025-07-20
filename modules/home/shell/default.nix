{...}: {
  imports = [
    ./fish
    ./starship.nix
  ];

  hydenix.hm.shell = {
    enable = true;
    zsh.enable = false;
    bash.enable = false;
    fish.enable = true;
    starship.enable = false;
    fastfetch.enable = true;
  };
}
