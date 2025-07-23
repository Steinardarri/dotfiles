{...}: {
  programs.kitty = {
    enable = true;
    enableGitIntegration = true; # Kitty diff integration
    shellIntegration.enableFishIntegration = true;

    settings = {
      "bold_font" = "auto";
      "italic_font" = "auto";
      "bold_italic_font" = "auto";
      "enable_audio_bell" = "no";
      "font_size" = "14.0";
      "window_padding_width" = "25";
      "cursor_trail" = "1";

      "tab_bar_edge" = "bottom";
      "tab_bar_style" = "powerline";
      "tab_powerline_style" = "slanted";
      "tab_title_template" = "{title}{' :{}:'.format(num_windows) if num_windows > 1 else ''}";
    };
  };
}
