{
  pkgs,
  lib,
  hostname,
  ...
}: let
  inherit (import ../../hosts/${hostname}/options.nix) kitty;
in
  lib.mkIf (kitty == true) {
    # Configure Kitty
    programs.kitty = {
      enable = true;
      package = pkgs.kitty;
      font.name = "Hack NF FC Ligatured CCG";
      font.size = 14;
      settings = {
        scrollback_lines = 2000;
        wheel_scroll_min_lines = 1;
        window_padding_width = 4;
        confirm_os_window_close = 0;
        background_opacity = "0.85";
      };
      extraConfig = ''
        tab_bar_style fade
        tab_fade 1
        active_tab_font_style   bold
        inactive_tab_font_style bold
      '';
    };
  }
