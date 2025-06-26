# Configuration for Stylix
# https://github.com/danth/stylix
# Genshin Impact by miHoYo
# https://genshin.hoyoverse.com/en
{pkgs, ...}: {
  stylix = {
    image = pkgs.fetchurl {
      name = "Kazuha.jpg";
      url = "https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.hdwallpapers.in%2Fdownload%2Fkazuha_4k_hd_genshin_impact_3-HD.jpg";
      sha256 = "u1OdK21k1sFBLQqLDjLBv/SRm6oiF36QRKrPTqjyohY=";
    };

    polarity = "light";

    fonts = rec {
      monospace = {
        name = "Fira Code";
        package = pkgs.fira-code;
      };
      sansSerif = {
        name = "Cantarell";
        package = pkgs.cantarell-fonts;
      };
      serif = sansSerif;
    };

    cursor = {
      package = pkgs.qogir-icon-theme;
      name = "Qogir";
    };
  };
}
