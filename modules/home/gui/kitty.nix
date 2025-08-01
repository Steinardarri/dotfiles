{...}: {
  programs.kitty = {
    enable = true;
    enableGitIntegration = true; # Kitty diff integration
    shellIntegration.enableFishIntegration = true;

    settings = {
      enable_audio_bell = "no";
      font_size = "14.0";
      window_padding_width = "25";
      scrollback_lines = 10000;

      cursor_shape = "beam";
      cursor_shape_unfocused = "hollow";
      cursor_blink_interval = "0.5 ease-in-out";
      cursor_stop_blinking_after = 15;
      cursor_trail = "1";

      tab_bar_edge = "bottom";
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      tab_title_template = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
    };
  };
}
