{...}: {
  # https://github.com/danth/stylix
  # https://tinted-theming.github.io/base16-gallery/
  imports = [
    # Select Theme to use
    # ./dystopia
    ./fjara
    # ./soxin

    # kazuha.nix
  ];

  stylix = {
    targets.plymouth = {
      logo = ./nix-snowflake-colours.png;
      logoAnimated = true;
    };
  };

}
