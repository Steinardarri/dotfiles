{
  inputs,
  pkgs,
  config,
  KBDLayout,
  hyprlandMonitors,
  hyprlandWorkspaces,
  ...
}: let
  animations = import ./hypr/animations.nix;
  decoration = import ./hypr/decoration.nix;

  binds = import ./hypr/binds.nix;
in {
  imports = [
    ./walker

    ./fuzzel.nix
    ./notifications.nix
    ./packages.nix
  ];

  # https://wiki.hypr.land/Nix/Hyprland-on-Home-Manager/
  wayland.windowManager.hyprland = {
    enable = true;

    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    xwayland.enable = false;
    # https://wiki.hypr.land/Useful-Utilities/Systemd-start/#installation
    systemd.enable = false;

    settings = {
      # Imports
      monitor = hyprlandMonitors;
      decoration = decoration;
      animations = animations;
      workspace = hyprlandWorkspaces;

      # Main modifier
      "$mainMod" = "Super"; # super / meta / windows key

      # Assign apps
      "$launcher" = "walker";
      "$term" = "kitty";
      "$editor" = "codium";
      "$file" = "dolphin";
      "$browser" = "zen-browser";

      # Import bindings from binds.nix
      binddr = binds.binddr;
      bindd = binds.bindd;
      binddm = binds.binddm;
      bindde = binds.bindde;
      binddl = binds.binddl;
      binddel = binds.binddel;

      general = {
        gaps_in = 4;
        gaps_out = 5;
        gaps_workspaces = 50;
        border_size = 1;
        resize_on_border = true;
        no_focus_fallback = true;
        allow_tearing = true;

        snap = {
          enabled = true;
        };

        layout = "dwindle";
      };

      dwindle = {
        preserve_split = true;
        smart_split = false;
        smart_resizing = false;
      };

      input = {
        # Keyboard
        numlock_by_default = true;
        kb_layout = KBDLayout;
        kb_options = ["caps:hyper" "fkeys:basic_13-24"];
        repeat_rate = 35;
        repeat_delay = 250;

        # Mouse
        sensitivity = 0;
        accel_profile = "flat";
        follow_mouse = 1;
        float_switch_override_focus = 2;

        touchpad = {
          natural_scroll = true;
        };
      };

      gestures = {
        workspace_swipe = true;
        workspace_swipe_distance = 700;
        workspace_swipe_fingers = 3;
        workspace_swipe_min_fingers = true;
        workspace_swipe_cancel_ratio = 0.2;
        workspace_swipe_min_speed_to_force = 5;
        workspace_swipe_direction_lock = true;
        workspace_swipe_direction_lock_threshold = 10;
        workspace_swipe_create_new = true;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        vfr = 3;
        vrr = 3;
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        animate_manual_resizes = false;
        animate_mouse_windowdragging = false;
        enable_swallow = false;
        swallow_regex = "(kitty)";
        new_window_takes_over_fullscreen = 2;
        allow_session_lock_restore = true;
        initial_workspace_tracking = false;
        focus_on_activate = true;
      };

      binds = {
        scroll_event_delay = 0;
      };

      cursor = {
        inactive_timeout = 5;
        hide_on_key_press = true;
        hide_on_touch = true;
        default_monitor = "";
      };

      # Autostart applications
      exec-once = [
        # Core components
        # "gnome-keyring-daemon --start --components=secrets"
        # "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1"
        "hypridle"
        "dbus-update-activation-environment --all"
        # "sleep 1 && dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"

        # Clipboard history
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];
    };
  };

  # Make uwsm grab env variables from Home Manager
  xdg.configFile."uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
}
