# Configuration for Stylix
# https://github.com/danth/stylix
{pkgs, ...}: {
  stylix = {
    #image = ./dystopia.png;
    image = ./vagabond.jpg;
    polarity = "dark";
    #base16Scheme = "${pkgs.base16-schemes}/share/themes/vice.yaml";

    targets = {
      grub.useImage = true;
      gnome.enable = true;
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };

    fonts = rec {
      sansSerif = {
        name = "Noto Sans";
        package = pkgs.noto-fonts;
      };

      serif = sansSerif;

      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-emoji;
      };

      monospace = {
        name = "Hack Nerd Font";
        package = pkgs.nerdfonts.override {fonts = ["Hack"];};
      };
    };
  };
}
