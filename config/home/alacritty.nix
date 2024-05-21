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
          normal.family = "Hack NF FC Ligatured CCG";
          bold.family = "Hack NF FC Ligatured CCG";
          italic.family = "Hack NF FC Ligatured CCG";
          bold_italic.family = "Hack NF FC Ligatured CCG";
          size = 14;
        };
        colors = {
          draw_bold_text_with_bright_colors = true;
        };
      };
    };
  }
