{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [./style.nix];

  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings.mainBar = {
      layer = "top";
      position = "top";
      spacing = 0;
      reload_style_on_change = true;

      modules-left = [
        "custom/actions"
        "hyprland/workspaces"
        "hyprland/window"
      ];

      modules-center = [
        "systemd-failed-units"
        "clock"
        "mpris"
      ];

      modules-right = [
        "backlight"
        "wireplumber"
        "group/power"
        "group/hardware"
        "tray"
      ];

      "custom/actions" = {
        format = "";
        tooltip-format = "System Actions";
        on-click = "fuzzel-actions";
      };

      "hyprland/workspaces" = {
        show-special = true;
        special-visible-only = true;
        format = "{icon}";

        persistent-workspaces = {
          "*" = 3;
        };
      };

      "hyprland/window" = {
        max-length = 50;
        format = "{title}";
        icon = true;
      };

      systemd-failed-units = {
        format = "✗ {nr_failed}";
        on-click = "kitty -H -- fish -c \"bat -f (systemctl list-units --user --failed | psub -s -user-units) (systemctl list-units --failed | psub -s -system-units)\"";
      };

      clock = {
        format = "  {:%H:%M}";
        format-alt = "  {:%a, %d %b}";

        tooltip-format = "<tt><small>{calendar}</small></tt>";
        calendar = {
          mode = "month";
          weeks-pos = "left";
          mode-mon-col = 3;
          format = let
            colors = config.lib.stylix.colors.withHashtag;
          in {
            months = "<span color='${colors.base06}'><b>{}</b></span>";
            days = "<span color='${colors.base05}'><b>{}</b></span>";
            weeks = "<span color='${colors.base0E}'><b>W{}</b></span>";
            weekdays = "<span color='${colors.base0A}'><b>{}</b></span>";
            today = "<span color='${colors.base0B}'><b><u>{}</u></b></span>";
          };
        };

        actions = {
          on-click-right = "mode";
          on-click-middle = "shift_reset";
          on-scroll-up = "shift_up";
          on-scroll-down = "shift_down";
        };
      };

      mpris = let
        playerctl = lib.getExe pkgs.playerctl;
      in {
        player = "spotify";
        format = "{player_icon} {status_icon} <b>{title}</b> by <i>{artist}</i>";
        tooltip-format = "Album: {album}";
        artist-len = 12;
        title-len = 22;
        ellipsis = "...";
        player-icons = {
          default = "";
          spotify = "󰓇";
          kdeconnect = "";
        };
        status-icons = {
          paused = "󰏤";
        };
        on-scroll-up = "${playerctl} volume 0.1+";
        on-scroll-down = "${playerctl} volume 0.1-";
      };

      backlight = {
        format = "{icon}  {percent}%";
        format-icons = [
          "󱩎 "
          "󱩏 "
          "󱩐 "
          "󱩑 "
          "󱩒 "
          "󱩓 "
          "󱩔 "
          "󱩕 "
          "󱩖 "
          "󰛨 "
        ];
        tooltip = false;
      };

      wireplumber = {
        format = "{icon}  {volume}%";
        format-muted = "󰝟";
        on-click = lib.getExe pkgs.pwvucontrol;
        format-icons = [
          "󰕿"
          "󰖀"
          "󰕾"
        ];
      };

      "group/power" = {
        orientation = "inherit";

        drawer = {
          transition-duration = 300;
          transition-left-to-right = false;
        };

        modules = [
          "battery"
          "idle_inhibitor"
          "power-profiles-daemon"
        ];
      };

      battery = {
        states = {
          warning = 30;
          critical = 20;
        };
        format = "{icon}  {capacity}%";
        format-time = "{H}h {M}min";
        format-charging = "󱐋  {capacity}%";
        format-plugged = "  {capacity}%";
        format-alt = "{icon}  {time}";
        format-icons = [
          " "
          " "
          " "
          " "
          " "
        ];

        tooltip-format = "{timeTo}\nPower: {power}W";
      };

      idle_inhibitor = {
        format = "{icon}";

        format-icons = {
          activated = " ";
          deactivated = " ";
        };
      };

      power-profiles-daemon = {
        format = "{icon}";
        tooltip-format = "Power profile: {profile}\nDriver: {driver}";
        tooltip = true;
        format-icons = {
          default = "";
          performance = "";
          balanced = "";
          power-saver = "";
        };
      };

      "group/hardware" = {
        orientation = "inherit";

        drawer = {
          transition-duration = 300;
          transition-left-to-right = false;
        };

        modules = [
          "custom/monitor"
          "disk"
          "cpu"
          "temperature"
          "memory"
        ];
      };

      disk = {
        format = "󰋊 {percentage_free}%";
      };

      cpu = {
        format = "  {usage}%";
        interval = 2;
      };

      temperature = {
        format = "  {temperatureC}°C";
        interval = 2;
        critical-format = "󰸁 {temperatureC}°C";
        critical-threshold = 90;
      };

      memory = {
        format = "  {used}/{total}GiB";
        interval = 2;
      };

      tray = {
        spacing = 5;
      };
    };
  };

  systemd.user.services.waybar.Unit.After = lib.mkForce "graphical-session.target";

  # xdg.configFile."waybar/config" = {
  #   source = "$XDG_CONFIG_HOME/waybar/config";
  #   onChange = ''
  #     ${pkgs.procps}/bin/pkill -u $USER waybar || true
  #   '';
  # };
}
