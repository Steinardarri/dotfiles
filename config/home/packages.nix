{
  pkgs,
  hostname,
  ...
}: let
  inherit
    (import ../../hosts/${hostname}/options.nix)
    browser
    ;
in {
  # Install Packages For The User
  home.packages = with pkgs; [
    pkgs."${browser}"
    discord
    swww
    gimp
    font-awesome
    spotify
    lapce
    protonvpn-gui
    kdePackages.kpat
    kdePackages.picmi
    kdePackages.ktorrent
    kdePackages.kcalc
  ];
}
