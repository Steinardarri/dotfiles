{...}: {
  imports = [
    ./cli
    ./gui
    ./hyprland
    ./services
    ./tui

    ./git.nix
    ./gtk.nix
    ./qt.nix
    ./xdg.nix
  ];

  home.stateVersion = "25.05";
}
