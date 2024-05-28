# Configuration for Stylix
# https://github.com/danth/stylix
{pkgs, ...}: {
  stylix = {
    #image = ./dystopia.png;
    image = ./vagabond.jpg;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/vice.yaml";

    targets = {
      grub.useImage = true;
      gnome.enable = true;
    };

    opacity = {
      popups = 0.9;
      terminal = 0.9;
    };

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 24;
    };


    fonts = rec {
    sansSerif = {
        name = "TeX Gyre Heros";
        package = pkgs.gyre-fonts;
      };

      serif = sansSerif;

      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-emoji;
      };

      monospace = let
        HackNF = with pkgs; [(nerdfonts.override {fonts = ["Hack" "FiraCode" "DroidSansMono"];})];
      in {
        name = "Hack NF FC Ligatured CCG";
        package = builtins.elemAt HackNF 0;
      };
    };
  };
}
