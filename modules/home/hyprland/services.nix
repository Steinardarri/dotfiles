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

      background = [
        {
          blur_passes = 3;
          blur_size = 8;
        }
      ];

      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = lib.mkDefault "rgb(202, 211, 245)";
          inner_color = lib.mkDefault "rgb(91, 96, 120)";
          outer_color = lib.mkDefault "rgb(24, 25, 38)";
          outline_thickness = 5;
          placeholder_text = "'<span foreground=\"##cad3f5\">Password...</span>'";
          shadow_passes = 2;
        }
      ];
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
      transitions = {
        sunrise = {
          calendar = "*-*-* 06:00:00";
          requests = [
            ["temperature" "6500"]
            ["gamma 100"]
          ];
        };
        sunset = {
          calendar = "*-*-* 22:00:00";
          requests = [
            ["temperature" "3500"]
          ];
        };
      };
    };
  };
}
