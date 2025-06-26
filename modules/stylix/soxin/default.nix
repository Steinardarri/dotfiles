# Configuration for Stylix
# https://github.com/danth/stylix
# https://tinted-theming.github.io/base16-gallery/
{pkgs, ...}: let
  theme = "${pkgs.base16-schemes}/share/themes/vice.yaml";
  wallpaper = pkgs.runCommand "./nix-snowflake-colours-wallpaper.png" {} ''
    COLORM=$(${pkgs.yq}/bin/yq -r .base00 ${theme})
    COLORA=$(${pkgs.yq}/bin/yq -r .base08 ${theme})
    COLORB=$(${pkgs.yq}/bin/yq -r .base09 ${theme})

    COLORM="#"$COLORM

    COLORA1=$(${pkgs.pastel}/bin/pastel )
    COLORA2="#"$COLORA
    COLORA3="#"$COLORA

    COLORB1="#"$COLORB
    COLORB2="#"$COLORB
    COLORB3="#"$COLORB

    # Old and new base colors
    COLOR1_OLD="oldcolor1_base"
    COLOR2_OLD="oldcolor2_base"

    COLOR1_NEW="newcolor1_base"
    COLOR2_NEW="newcolor2_base"

    # Calculate new gradient colors based on the differences in the old gradient colors
    # and the new base colors. Replace these with your actual color calculation logic.
    COLOR1_NEW_STOP1=$(calculate_new_color $COLOR1_NEW $COLOR1_OLD "oldcolor1_stop1")
    COLOR1_NEW_STOP2=$(calculate_new_color $COLOR1_NEW $COLOR1_OLD "oldcolor1_stop2")
    COLOR1_NEW_STOP3=$(calculate_new_color $COLOR1_NEW $COLOR1_OLD "oldcolor1_stop3")

    COLOR2_NEW_STOP1=$(calculate_new_color $COLOR2_NEW $COLOR2_OLD "oldcolor2_stop1")
    COLOR2_NEW_STOP2=$(calculate_new_color $COLOR2_NEW $COLOR2_OLD "oldcolor2_stop2")
    COLOR2_NEW_STOP3=$(calculate_new_color $COLOR2_NEW $COLOR2_OLD "oldcolor2_stop3")

    # Use xmlstarlet to replace colors
    xmlstarlet ed -L -u "//svg:linearGradient[@id='gradient1']/svg:stop[@id='stop1']/@stop-color" -v "$COLOR1_NEW_STOP1" $SVG_FILE
    xmlstarlet ed -L -u "//svg:linearGradient[@id='gradient1']/svg:stop[@id='stop2']/@stop-color" -v "$COLOR1_NEW_STOP2" $SVG_FILE
    xmlstarlet ed -L -u "//svg:linearGradient[@id='gradient1']/svg:stop[@id='stop3']/@stop-color" -v "$COLOR1_NEW_STOP3" $SVG_FILE

    xmlstarlet ed -L -u "//svg:linearGradient[@id='gradient2']/svg:stop[@id='stop1']/@stop-color" -v "$COLOR2_NEW_STOP1" $SVG_FILE
    xmlstarlet ed -L -u "//svg:linearGradient[@id='gradient2']/svg:stop[@id='stop2']/@stop-color" -v "$COLOR2_NEW_STOP2" $SVG_FILE
    xmlstarlet ed -L -u "//svg:linearGradient[@id='gradient2']/svg:stop[@id='stop3']/@stop-color" -v "$COLOR2_NEW_STOP3" $SVG_FILE


    ${pkgs.xmlstarlet}/bin/xmlstarlet ed -u
  '';
in {
  stylix = {
    base16Scheme = theme;
    image = wallpaper;

    targets = {
      grub.useImage = true;
      gnome.enable = true;
    };

    opacity = {
      popups = 0.8;
    };

    cursor = {
      package = pkgs.breeze-hacked-cursor-theme.override {};
      name = "Breeze Hacked";
      size = 24;
    };

    fonts = rec {
      sansSerif = {
        name = "Cantarell";
        package = pkgs.cantarell-fonts;
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
