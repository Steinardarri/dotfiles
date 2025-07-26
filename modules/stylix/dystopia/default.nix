# Configuration for Stylix
# https://github.com/danth/stylix
{pkgs, ...}: {
  stylix = {
    #image = ./dystopia.png;
    image = ./vagabond.jpg;
    polarity = "dark";

    cursor = {
      package = pkgs.bibata-cursors-translucent;
      name = "Bibata Spirit";
      size = 24;
    };

    fonts = rec {
      sansSerif = {
        name = "Fira Sans";
        package = pkgs.fira-sans;
      };

      serif = sansSerif;

      monospace = {
        name = "Hack Nerd Font";
        package = pkgs.nerd-fonts.hack;
      };

      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-emoji;
      };
    };
  };
}
