{
  inputs,
  pkgs,
  config,
  lib,
  KBDLayout,
  hyprlandMonitors,
  hyprlandWorkspaces,
  ...
}: {
  imports = [
    ./hypr/rules.nix

    ./hyprpanel

    ./fuzzel.nix
    ./packages.nix
    ./services.nix
    ./sherlock.nix
  ];

  # https://wiki.hypr.land/Nix/Hyprland-on-Home-Manager/
  wayland.windowManager.hyprland = let
    hypr-pkgs = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
  in {
    enable = true;
    package = hypr-pkgs.hyprland;
    portalPackage = hypr-pkgs.xdg-desktop-portal-hyprland;

    # Disable XWayland when Steam finally gets a 64 bit wayland client
    xwayland.enable = true;
    # https://wiki.hypr.land/Useful-Utilities/Systemd-start/#installation
    # Systemd setting conflicts with uwsm
    systemd.enable = false;

    settings = let
      binds = import ./hypr/binds.nix;
    in {
      # Imports
      animations = import ./hypr/animations.nix;
      decoration = import ./hypr/decoration.nix {
        inherit config;
        inherit lib;
      };
      monitor = hyprlandMonitors;
      workspace = hyprlandWorkspaces;
      "plugin:dynamic-cursors" =
        import
        ./hypr/dynamic-cursors.nix;

      # Import bindings from binds.nix
      inherit (binds) binddr;
      inherit (binds) bindd;
      inherit (binds) binddm;
      inherit (binds) bindde;
      inherit (binds) binddl;
      inherit (binds) binddel;

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
        pseudotile = true;
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
        scroll_method = "2fg";

        touchpad = {
          natural_scroll = true;
        };
      };

      cursor = {
        inactive_timeout = 5;
        hide_on_key_press = false;
        hide_on_touch = true;
        default_monitor = "DP-2";
        no_hardware_cursors = false;
        use_cpu_buffer = true;
      };

      render = {
        new_render_scheduling = true;
        direct_scanout = true;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        # disable auto polling for config file changes
        disable_autoreload = true;
        vfr = 3;
        vrr = 3;
        mouse_move_enables_dpms = false;
        key_press_enables_dpms = true;
        animate_manual_resizes = true;
        animate_mouse_windowdragging = true;
        enable_swallow = false;
        swallow_regex = "([Kk]itty)";
        new_window_takes_over_fullscreen = 2;
        allow_session_lock_restore = true;
        initial_workspace_tracking = false;
        focus_on_activate = true;
        # No 'application not responding' prompt
        enable_anr_dialog = false;
      };

      binds = {
        scroll_event_delay = 0;
      };

      exec-once = [
      ];
    };

    plugins = [inputs.hypr-dynamic-cursors.packages.${pkgs.stdenv.hostPlatform.system}.hypr-dynamic-cursors];
  };

  home.sessionVariables = {
    HYPRSHOT_DIR = "${config.home.homeDirectory}/Pictures/Screenshots";
  };

  # Make uwsm grab env variables from Home Manager
  xdg.configFile."uwsm/env".source = "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
}
