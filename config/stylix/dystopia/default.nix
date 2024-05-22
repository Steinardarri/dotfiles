# Configuration for Stylix
# https://github.com/danth/stylix
{pkgs, ...}: {
  stylix = {
    image = ./dystopia.png;

    polarity = "dark";

    cursor.package = pkgs.bibata-cursors;
    cursor.name = "Bibata-Modern-Classic";

    fonts = {
      monospace = {
        package = pkgs.nerdfonts.override {fonts = ["Hack"];};
        name = "Hack Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
    };
  };
}
