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
        getFrom = url: hash: name: {
          name = "Hack NF FC Ligatured CCG";
          package = pkgs.runCommand "moveUp" {} ''
            mkdir -p /home/${username}/.local/share/fonts
            ln -s ${pkgs.fetchzip {
              url = url;
              hash = hash;
            }} /home/${username}/.local/share/fonts/${name}
          '';
        };
      in
        getFrom
        "https://github.com/gaplo917/Ligatured-Hack/releases/download/v3.003%2BNv2.1.0%2BFC%2BJBMv2.242/HackLigatured-v3.003+FC3.1+JBMv2.242.zip"
        "sha256-BvVE9qupMjw7JRqFUj1J0a4ys6kc9fOLBPx2bGaapTk="
        "Ligatured-Hack";
    };
  };
}
