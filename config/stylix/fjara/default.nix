# Configuration for Stylix
# https://github.com/danth/stylix
{
  pkgs,
  username,
  ...
}: {
  stylix = {
    image = ./eidsgrandi.png;
    polarity = "dark";

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

    fonts = {
      serif = {
        name = "DejaVu Serif";
        package = pkgs.dejavu_fonts;
      };

      sansSerif = {
        name = "DejaVu Sans";
        package = pkgs.dejavu_fonts;
      };

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
