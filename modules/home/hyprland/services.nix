{lib, ...}: {
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        disable_loading_bar = true;
        grace = 300;
        hide_cursor = true;
        no_fade_in = false;
      };

      background = {
        blur_passes = lib.mkDefault 3;
        blur_size = lib.mkDefault 8;
      };

      input-field = lib.mkDefault {
        size = "200, 50";
        position = "0, -80";
        monitor = "";
        dots_center = true;
        fade_on_empty = false;
        font_color =  "rgb(202, 211, 245)";
        inner_color = "rgb(91, 96, 120)";
        outer_color = "rgb(24, 25, 38)";
        outline_thickness = 5;
        placeholder_text = "'<span foreground=\"##cad3f5\">Password...</span>'";
        shadow_passes = 2;
      };
    };
  };

  services = {
    hyprpolkitagent.enable = true;

    hypridle = {
      enable = true;

      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = "hyprlock";
        };

        listener = [
          {
            timeout = 900;
            on-timeout = "hyprlock";
          }
          {
            timeout = 3600;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
    };

    hyprsunset = {
      enable = true;
      settings = {
          profile = [
            {
              time = "7:00";
              identity = true;
            }
            {
              time = "22:00";
              temperature = 3500;
              gamma = 0.8;
            }
          ];
        };
    };
  };
}
