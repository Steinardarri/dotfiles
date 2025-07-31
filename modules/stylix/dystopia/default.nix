{pkgs, ...}: {
  stylix = {
    #image = ./dystopia.png;
    image = ./vagabond.jpg;
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/vice.yaml";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa.yaml";
    polarity = "dark";

    fonts = let
      sansSerif = {
        name = "Lato";
        package = pkgs.lato;
      };
    in {
      sansSerif = sansSerif;

      serif = sansSerif;

      monospace = {
        name = "Hack Nerd Font Mono";
        package = pkgs.nerd-fonts.hack;
      };

      emoji = {
        name = "Noto Color Emoji";
        package = pkgs.noto-fonts-emoji;
      };
    };
  };
}
