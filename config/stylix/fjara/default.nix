# Configuration for Stylix
# https://github.com/danth/stylix
{pkgs, ...}: {
  stylix = {
    image = ./eidsgrandi.png;
    polarity = "dark";

    targets = {
      grub.useImage = true;
      gnome.enable = true;
    };

    cursor.package = pkgs.bibata-cursors;
    cursor.name = "Bibata-Modern-Classic";
    cursor.size = 24;

    opacity = {
      popups = 0.9;
      terminal = 0.9;
    };
  };
}
