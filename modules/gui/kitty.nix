_: {
  programs.kitty = {
    enable = true;
    enableGitIntegration = true; # Kitty diff integration
    shellIntegration.enableFishIntegration = true;
    shellIntegration.enableZshIntegration = true;

    settings = {
      enable_audio_bell = "no";
      font_size = "14.0";
      window_padding_width = "25";
      scrollback_lines = 10000;

      allow_remote_control = "yes";

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

    keybindings = {
      "ctrl+shift+enter" = "new_window_with_cwd";
      "ctrl+alt+t" = "goto_layout tall";
      "ctrl+alt+g" = "goto_layout grid";
      "ctrl+alt+z" = "toggle_layout stack";
      "ctrl+alt+right" = "next_window";
      "ctrl+alt+left" = "previous_window";
    };

    actionAliases = {
      "launch_tab" = "launch --cwd=current --type=tab";
      "launch_window" = "launch --cwd=current --type=os-window";
    };
  };

  home.sessionVariables = {
    TERM = "kitty";
  };
}
