let
  launcherBind = let
    d = "[Launcher]";
  in [
    "$mainMod, Super_L, ${d} launcher, exec, $launcher"
  ];

  appBinds = let
    d = "[Launcher|Apps]";
  in [
    "$mainMod, Return, ${d} terminal emulator, exec, $term"
    "$mainMod Shift, Return, ${d} dropdown terminal, exec, [float; move 20% 5%; size 60% 60%] $term"
    "$mainMod, E, ${d} file explorer, exec, $file"
    "$mainMod, N, ${d} text editor, exec, $editor"
    "$mainMod, W, ${d} web browser, exec, $browser"
    "Control Shift, Escape, ${d} system monitor, exec, $scrPath/sysmonlaunch.sh"
  ];

  windowManagement = let
    d = "[Window Management]";
  in [
    "$mainMod, Q, ${d} close focused window, exec, $scrPath/dontkillsteam.sh"
    "Alt, F4, ${d} close focused window, exec, $scrPath/dontkillsteam.sh"
    "$mainMod, Delete, ${d} kill hyprland session, exit"
    "$mainMod, V, ${d} Toggle floating, togglefloating"
    "$mainMod, G, ${d} toggle group, togglegroup"
    "Shift, F11, ${d} toggle fullscreen, fullscreen"
    "$mainMod, J, ${d} toggle split, togglesplit"
    "$mainMod, L, ${d} lock screen, exec, lockscreen.sh"
    "$mainMod Shift, F, ${d} toggle pin on focused window, exec, $scrPath/windowpin.sh"
    "Control Alt, Delete, ${d} logout menu, exec, $scrPath/logoutlaunch.sh"
    # "Alt_R, Control_R, ${d} toggle waybar and reload config, exec, hyde-shell waybar --hide"
  ];

  groupNavigation = let
    d = "[Window Management|Group Navigation]";
  in [
    "$mainMod Control, H, ${d} change active group backwards, changegroupactive, b"
    "$mainMod Control, L, ${d} change active group forwards, changegroupactive, f"
  ];

  changeFocus = let
    d = "[Window Management|Change focus]";
  in [
    "$mainMod, Left, ${d} focus left, movefocus, l"
    "$mainMod, Right, ${d} focus right, movefocus, r"
    "$mainMod, Up, ${d} focus up, movefocus, u"
    "$mainMod, Down, ${d} focus down, movefocus, d"
    "ALT, Tab, ${d} Cycle focus, cyclenext"
  ];

  resizeActiveWindow = let
    d = "[Window Management|Resize Active Window]";
  in [
    "$mainMod Alt Control, Right, ${d} resize window right, resizeactive, 30 0"
    "$mainMod Alt Control, Left, ${d} resize window left, resizeactive, -30 0"
    "$mainMod Alt Control, Up, ${d} resize window up, resizeactive, 0 -30"
    "$mainMod Alt Control, Down, ${d} resize  window down, resizeactive, 0 30"
  ];

  moveActiveWindowWorkspace = let
    d = "[Window Management|Move Active Window Across Workspaces]";
    moveactivewindow = "grep -q \"true\" <<< $(hyprctl activewindow -j | jq -r .floating) && hyprctl dispatch moveactive";
  in [
    "$mainMod Shift, left, ${d} Move active window to the left, exec, ${moveactivewindow} -30 0 || hyprctl dispatch movewindow l"
    "$mainMod Shift, right, ${d} Move active window to the right, exec, ${moveactivewindow} 30 0 || hyprctl dispatch movewindow r"
    "$mainMod Shift, up, ${d} Move active window up, exec, ${moveactivewindow}  0 -30 || hyprctl dispatch movewindow u"
    "$mainMod Shift, down, ${d} Move active window down, exec, ${moveactivewindow} 0 30 || hyprctl dispatch movewindow d"
  ];

  moveResizeWithMouse = let
    d = "[Window Management|Move & Resize With Mouse]";
  in [
    "$mainMod, mouse:272, ${d} hold to move window, movewindow"
    "$mainMod, mouse:273, ${d} hold to resize window, resizewindow"
    "$mainMod, Z, ${d} hold to move window, movewindow"
    "$mainMod, X, ${d} hold to resize window, resizewindow"
  ];

  media = let
    d = "[Hardware Controls|Media]";
  in [
    # Toggle between media play and pause
    ", XF86AudioPlay, ${d} play media, exec, playerctl play-pause"
    ", XF86AudioPause, ${d} pause media, exec, playerctl play-pause"

    ", XF86AudioNext, ${d} next media, exec, playerctl next"
    ", XF86AudioPrev, ${d}  previous media, exec, playerctl previous"
  ];

  lockedRepeatBinds = [];

  workspaceNavigation = let
    d = "[Workspaces|Navigation]";
  in [
    "$mainMod, 1, ${d} navigate to workspace 1, workspace, 1"
    "$mainMod, 2, ${d} navigate to workspace 2, workspace, 2"
    "$mainMod, 3, ${d} navigate to workspace 3, workspace, 3"
    "$mainMod, 4, ${d} navigate to workspace 4, workspace, 4"
    "$mainMod, 5, ${d} navigate to workspace 5, workspace, 5"
    "$mainMod, 6, ${d} navigate to workspace 6, workspace, 6"
    "$mainMod, 7, ${d} navigate to workspace 7, workspace, 7"
    "$mainMod, 8, ${d} navigate to workspace 8, workspace, 8"
    "$mainMod, 9, ${d} navigate to workspace 9, workspace, 9"
    "$mainMod, 0, ${d} navigate to workspace 10, workspace, 10"
    "$mainMod Control, Down, ${d} navigate to the nearest empty workspace, workspace, empty"
    # Move focused window to a relative workspace
    "$mainMod Control Shift, Right, ${d} move window to next relative workspace, movetoworkspace, r+1"
    "$mainMod Control Shift, Left, ${d} move window to previous relative workspace, movetoworkspace, r-1"
    # Scroll through workspaces
    "$mainMod, mouse_down, ${d} next workspace, workspace, e+1"
    "$mainMod, mouse_up, ${d} previous workspace, workspace, e-1"
  ];

  workspaceRelativeNavigation = let
    d = "[Workspaces|Navigation|Relative workspace]";
  in [
    "$mainMod Control, Left, ${d} change active workspace backwards, workspace, r-1"
    "$mainMod Control, Right, ${d} change active workspace forwards, workspace, r+1"
  ];

  moveWindowToWorkspace = let
    d = "[Workspaces|Move Window To Workspace]";
  in [
    "$mainMod Shift, 1, ${d} move to workspace 1, movetoworkspace, 1"
    "$mainMod Shift, 2, ${d} move to workspace 2, movetoworkspace, 2"
    "$mainMod Shift, 3, ${d} move to workspace 3, movetoworkspace, 3"
    "$mainMod Shift, 4, ${d} move to workspace 4, movetoworkspace, 4"
    "$mainMod Shift, 5, ${d} move to workspace 5, movetoworkspace, 5"
    "$mainMod Shift, 6, ${d} move to workspace 6, movetoworkspace, 6"
    "$mainMod Shift, 7, ${d} move to workspace 7, movetoworkspace, 7"
    "$mainMod Shift, 8, ${d} move to workspace 8, movetoworkspace, 8"
    "$mainMod Shift, 9, ${d} move to workspace 9, movetoworkspace, 9"
    "$mainMod Shift, 0, ${d} move to workspace 10, movetoworkspace, 10"
  ];

  # Move/Switch to special workspace (scratchpad)
  moveSwitchSpecialWorkspace = let
    d = "[Workspaces|Navigation|Special Workspace]";
  in [
    "$mainMod Shift, S, ${d} move to scratchpad, movetoworkspace, special"
    "$mainMod Alt, S, ${d} move to scratchpad (silent), movetoworkspacesilent, special"
    "$mainMod, S, ${d} toggle scratchpad,  togglespecialworkspace"
  ];

  moveWindowToWorkspaceSilent = let
    d = "[Workspaces|Navigation|Move window silently]";
  in [
    "$mainMod Alt, 1, ${d} move to workspace 1  (silent), movetoworkspacesilent, 1"
    "$mainMod Alt, 2, ${d} move to workspace 2  (silent), movetoworkspacesilent, 2"
    "$mainMod Alt, 3, ${d} move to workspace 3  (silent), movetoworkspacesilent, 3"
    "$mainMod Alt, 4, ${d} move to workspace 4  (silent), movetoworkspacesilent, 4"
    "$mainMod Alt, 5, ${d} move to workspace 5  (silent), movetoworkspacesilent, 5"
    "$mainMod Alt, 6, ${d} move to workspace 6  (silent), movetoworkspacesilent, 6"
    "$mainMod Alt, 7, ${d} move to workspace 7  (silent), movetoworkspacesilent, 7"
    "$mainMod Alt, 8, ${d} move to workspace 8  (silent), movetoworkspacesilent, 8"
    "$mainMod Alt, 9, ${d} move to workspace 9  (silent), movetoworkspacesilent, 9"
    "$mainMod Alt, 0, ${d} move to workspace 10 (silent), movetoworkspacesilent, 10"
  ];
in {
  # For bind flag suffixes
  # https://wiki.hypr.land/Configuring/Binds/#bind-flags

  # Bindings on key release
  binddr = launcherBind;

  # Regular bindings
  bindd = appBinds ++ windowManagement ++ groupNavigation ++ changeFocus ++ workspaceNavigation ++ workspaceRelativeNavigation ++ moveWindowToWorkspace ++ moveSwitchSpecialWorkspace ++ moveWindowToWorkspaceSilent;

  # Mouse bindings
  binddm = moveResizeWithMouse;

  # Repeating bindings
  bindde = resizeActiveWindow ++ moveActiveWindowWorkspace;

  # Locked bindings
  binddl = media;

  # Locked repeating bindings
  binddel = lockedRepeatBinds;
}
