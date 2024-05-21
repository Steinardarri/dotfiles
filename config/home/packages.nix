{
  pkgs,
  config,
  username,
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
  ];
}
