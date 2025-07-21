{ ...}: {
  imports = [
    ./gui
    ./services
    ./shell
    ./tui

    ./git.nix
  ];

  hydenix.hm = {
    enable = true;
    comma.enable = true; # useful nix tool to run software without installing it first
    dolphin.enable = true;
    fastfetch.enable = true;
    firefox.enable = false;
    git.enable = true;
    gtk.enable = true;
    hyde.enable = true;
    hyprland = {
      enable = true;
      extraConfig = "";
    };
    lockscreen = {
      enable = true;
      hyprlock = true;
      swaylock = false;
    };
    notifications.enable = true;
    qt.enable = true;
    rofi.enable = true;
    screenshots = {
      enable = true;
      grim.enable = true; # enable grim screenshot tool
      slurp.enable = true; # enable slurp region selection tool
      satty.enable = false; # false do to error
      swappy.enable = true; # enable swappy screenshot editor
    };
    # Installed equibop on system
    social = {
      enable = false;
      discord.enable = false;
      webcord.enable = false;
      vesktop.enable = false;
    };
    spotify.enable = true;
    swww.enable = true;
    terminals = {
      enable = true;
      kitty = {
        enable = true;
        configText = "";
      };
    };
    theme = {
      enable = true;
      active = "Catppuccin Mocha";
      themes = [
        "Catppuccin Mocha"
        "Catppuccin Latte"
      ]; # default enabled themes, full list in https://github.com/richen604/hydenix/tree/main/hydenix/sources/themes
    };
    waybar = {
      enable = true;
      userStyle = "";
    };
    wlogout.enable = true;
    xdg.enable = true;
  };
}
