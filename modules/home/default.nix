{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./gui
    ./hyprland
    ./services
    ./shell
    ./tui

    ./git.nix
    ./gtk.nix
    ./qt.nix
    ./xdg.nix
  ];

  # Let home-manager control itself
  programs.home-manager.enable = true;

  home.stateVersion = "25.05";
}
