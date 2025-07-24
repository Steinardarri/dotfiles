{...}: {
  imports = [
    ./cli
    ./gui
    ./hyprland
    ./services
    ./tui

    ./git.nix
    ./xdg.nix
  ];

  hydenix.hm = {
    enable = true;
    firefox.enable = false; # using zen-browser instead
    qt.enable = true;
    social = {
      # Installed equibop system-side
      enable = false;
      discord.enable = false;
      webcord.enable = false;
      vesktop.enable = false;
    };
  };
}
