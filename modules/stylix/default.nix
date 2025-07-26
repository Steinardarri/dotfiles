{stylixTheme, ...}: {
  # https://github.com/danth/stylix
  # https://tinted-theming.github.io/base16-gallery/
  imports = [
    ./${stylixTheme}
  ];

  stylix = {
    enable = true;
    autoEnable = true;
    targets = {
      plymouth = {
        logo = ./nix-snowflake-colours.png;
        logoAnimated = true;
      };
      grub.useImage = true;
    };
  };
}
