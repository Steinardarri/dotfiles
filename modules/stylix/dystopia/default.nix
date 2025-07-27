{pkgs, ...}: {
  stylix = {
    #image = ./dystopia.png;
    image = ./vagabond.jpg;
    polarity = "dark";

    fonts = rec {
      sansSerif = {
        name = "Fira Sans";
        package = pkgs.fira-sans;
      };

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
