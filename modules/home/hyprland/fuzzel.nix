_: {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        placeholder = "Type to search...";
        prompt = "' '";
        launch-prefix = "uwsm-app --";
        match-counter = true;
        terminal = "kitty -e";
        horizontal-pad = 40;
        vertical-pad = 20;
        inner-pad = 15;
        image-size-ratio = 0.5;
        dpi-aware = "no";
        show-actions = "no";
      };

      border = {
        width = "2";
        radius = "7";
      };
    };
  };

  home.sessionVariables = {
    "LAUNCHER" = "fuzzel";
  };
}
