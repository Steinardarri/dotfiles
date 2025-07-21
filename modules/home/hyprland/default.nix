{lib, ...}: let
  # Custom Hyprland Configs
  hyde = import ./hypr/hyde.nix;
  monitor = import ./hypr/monitors.nix;
  input = import ./hypr/input.nix;
in {
  hydenix.hm = {
    hyde.enable = true;
    hyprland = {
      enable = true;
      extraConfig = hyde + monitor + input;
    };
    lockscreen = {
      enable = true;
      hyprlock = true;
      swaylock = false;
    };
    notifications.enable = true;
    rofi.enable = true;
    screenshots = {
      enable = true;
      grim.enable = true; # enable grim screenshot tool
      slurp.enable = true; # enable slurp region selection tool
      satty.enable = false; # false do to error
      swappy.enable = true; # enable swappy screenshot editor
    };
    swww.enable = true;
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
  };

  # Custom HyDE keybindings override
  home.file = {
    ".config/hypr/keybindings.conf".source = lib.mkForce ./hypr/keybindings.conf;
  };
}
