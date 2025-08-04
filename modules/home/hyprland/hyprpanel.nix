{
  inputs,
  pkgs,
  ...
}: {
  programs.hyprpanel = {
    enable = true;
    package = inputs.hyprpanel.packages.${pkgs.stdenv.hostPlatform.system}.default;

    # Not using other notification demons,
    # but the assertion won't pass
    dontAssertNotificationDaemons = true;

    settings = {
      bar = {
        layouts = {
          "0" = {
            left = ["dashboard" "workspaces"];
            middle = ["media"];
            right = ["volume" "systray" "notifications"];
          };
        };
        launcher.autoDetectIcon = true;
        workspaces.show_icons = true;
      };

      menus = {
        clock = {
          time = {
            military = true;
            hideSeconds = true;
          };
          weather.unit = "metric";
        };
        dashboard = {
          directories.enabled = false;
          stats.enable_gpu = true;
        };
      };

      theme = {
        bar.transparent = true;
        font = {
          name = "Hack Nerd Font Mono";
          size = "16px";
        };
      };
    };
  };
}
