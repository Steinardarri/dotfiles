{
  lib,
  hostname,
  ...
}: let
  inherit (import ../../hosts/${hostname}/options.nix) alacritty;
in
  lib.mkIf (alacritty == true) {
    programs.alacritty = {
      enable = true;
      settings = {
        window = {
          padding.x = 15;
          padding.y = 15;
          decorations = "none";
          startup_mode = "Windowed";
          dynamic_title = true;
          opacity = 0.6;
        };
        cursor = {
          style = {
            shape = "Beam";
            blinking = "On";
          };
        };
        live_config_reload = true;
        font = {
          normal.family = "Hack-NF-Ligatured";
          bold.family = "Hack-NF-Ligatured";
          italic.family = "Hack-NF-Ligatured";
          bold_italic.family = "Hack-NF-Ligatured";
          size = 16;
        };
        colors = {
          draw_bold_text_with_bright_colors = true;
        };
      };
    };
  }
