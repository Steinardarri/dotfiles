_: {
  wayland.windowManager.hyprland.settings = {
    "$floatingSize" = "60% 60%";
    "$pwvucontrol" = "com.saivert.pwvucontrol";

    windowrule = [
      # inhibit idle when fullscreen
      "idleinhibit focus, fullscreenstate:2 *"

      # Ignore maximize requests from apps
      "suppressevent maximize, class:.*"

      # Fix some dragging issues with XWayland
      "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

      # Games
      "immediate, class:^(steam_app_.*)$"

      ### Floating Apps

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
      "size 600 800, class:^(io.github.Qalculate.qalculate-qt)$"
      "move 20% 5%, class:^(io.github.Qalculate.qalculate-qt)$"

      # GUI Editor
      "float, title:^(Lapce)$"
      "size $floatingSize, title:^(Lapce)$"
      "center, title:^(Lapce)$"

      # Dim some programs
      "dimaround, class:^(xdg-desktop-portal-gtk)$"
      "dimaround, title:^(Hyprland Polkit Agent)$"
      "float, class:^(xdg-desktop-portal-gtk)$"
      "size $floatingSize, class:^(xdg-desktop-portal-gtk)$"
      "center, class:^(xdg-desktop-portal-gtk)$"

      "float, class:^(exo-desktop-item-edit)$"
      "size $floatingSize, class:^(exo-desktop-item-edit)$"
      "center, class:^(exo-desktop-item-edit)$"

      # General Popups
      "float, title:Properties$"
      "size $floatingSize, title:^(.*Properties)$"
      "center, title:Properties$"
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
