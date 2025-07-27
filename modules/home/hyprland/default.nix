{
  pkgs,
  inputs,
  lib,
  KBDLayout,
  hyprlandMonitors,
  hyprlandWorkspaces,
  ...
}: let
  animations = import ./hypr/animations.nix;
  decoration = import ./hypr/decoration.nix;
in {
  imports = [
    ./notifications.nix
  ];

  home.packages = with pkgs; [
    # Launchers
    fuzzel # Primary launcher/picker

    # Screenshot & recording
    hyprshot # Advanced screenshot tool
    grimblast # Backup screenshot tool
    grim # Basic screenshot
    slurp # Region selector
    tesseract # OCR
    satty # Screenshot annotation tool
    swappy # Screenshot editor
    wf-recorder # Screen recording

    # Clipboard & color
    cliphist # Clipboard history
    wl-clipboard # Clipboard utilities
    hyprpicker # Color picker

    # Wallpaper & display
    hyprpaper # Wallpaper daemon
    gammastep # Color temperature
    geoclue2 # Location for gammastep
    brightnessctl # Brightness control
    hyprsunset # blue-light filter

    # Lock & idle
    hypridle # Idle daemon
    hyprlock # Lock screen

    # Session
    wlogout # Power menu

    # Authentication
    hyprpolkitagent

    # Fonts and cursors
    hyprcursor

    # Utilities
    hyprutils
  ];

  # Easier to manage keybindings in hyprlang conf file
  home.file = {
    ".config/hypr/keybindings.conf".source = lib.mkForce ./hypr/keybindings.conf;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    xwayland.enable = false;

    # Import environment variables for systemd services
    systemd.variables = ["--all"];

    settings = {
      # Imports
      monitor = hyprlandMonitors;
      decoration = decoration;
      animations = animations;
      workspace = hyprlandWorkspaces;

      # CRITICAL: Global submap for dots-hyprland compatibility
      exec = "hyprctl dispatch submap global";
      submap = "global";

      # General appearance from dots-hyprland
      general = {
        gaps_in = 4;
        gaps_out = 5;
        gaps_workspaces = 50;
        border_size = 1;
        resize_on_border = true;
        no_focus_fallback = true;
        allow_tearing = true; # This just allows the immediate window rule to work

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
        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.
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
        # Wallpaper daemon and initial wallpaper
        "swww-daemon --format xrgb --no-cache"

        # Core components
        "gnome-keyring-daemon --start --components=secrets"
        "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1"
        "hypridle"
        "dbus-update-activation-environment --all"
        "sleep 1 && dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"

        # Clipboard history
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
      ];
    };
  };
}
