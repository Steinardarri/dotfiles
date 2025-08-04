_: {
  wayland.windowManager.hyprland.settings = {
    "$floatingSize" = "600 400";
    "$pwvucontrol" = "com.saivert.pwvucontrol";

    windowrule = [
      # inhibit idle when fullscreen
      "idleinhibit focus, fullscreenstate:2 *"

      # Ignore maximize requests from apps
      "suppressevent maximize, class:.*"

      # Fix some dragging issues with XWayland
      "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

      # NetworkManager applet
      "float, class:^(nm-connection-editor)$"
      "size $floatingSize, class:^(nm-connection-editor)$"
      "center, class:^(nm-connection-editor)$"

      # Blueman
      "float, class:^(.blueman-manager-wrapped)$"
      "size $floatingSize, class:^(.blueman-manager-wrapped)$"
      "center, class:^(.blueman-manager-wrapped)$"

      # Audio control
      "float, class:^($pwvucontrol)$"
      "size $floatingSize, class:^($pwvucontrol)$"
      "center, class:^($pwvucontrol)$"

      # make some windows floating and sticky
      "float, title:^(Picture-in-Picture)$" # firefox
      "pin, title:^(Picture-in-Picture)$" # firefox

      # Calculator
      "float, class:^(io.github.Qalculate.qalculate-qt)$"
      "size > >, class:^(io.github.Qalculate.qalculate-qt)$"

      # Dim some programs
      "dimaround, class:^(xdg-desktop-portal-gtk)$"
      "dimaround, title:^(Hyprland Polkit Agent)$"

      # Games
      "immediate, class:^(steam_app_.*)$"
    ];

    layerrule = [
      "animation slide, launcher"
      "dimaround, launcher"

      # Blur translucency
      "blur, waybar"
      "ignorezero, waybar"

      "blur, launcher"
      "ignorezero, launcher"

      "blur, notifications"
      "ignorezero, notifications"
    ];
  };
}
