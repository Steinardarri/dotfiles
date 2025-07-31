let
  launcherBind = let
    d = "[Launcher]";
  in [
    "Super, Super_L, ${d} launcher, exec, uwsm app -- fuzzel"
  ];

  appBinds = let
    d = "[Launcher|Apps]";
  in [
    "Super, Return, ${d} terminal emulator, exec, uwsm app -- kitty.desktop"
    "Super Shift, Return, ${d} dropdown terminal, exec, [float; move 20% 5%; size 60% 60%] uwsm app -- kitty.desktop"
    "Super, E, ${d} file explorer, exec, uwsm app -- org.kde.dolphin.desktop"
    "Super, N, ${d} text editor, exec, uwsm app -- codium.desktop"
    "Super, W, ${d} web browser, exec, uwsm app -- zen.desktop"
    # "Super, Escape, ${d} system monitor, exec, $scrPath/sysmonlaunch.sh"
  ];

  windowManagement = let
    d = "[Window Management]";
  in [
    "Super, Q, ${d} close focused window, killactive,"
    "Alt, F4, ${d} close focused window, killactive,"
    "Super Control, X, ${d} Kill clicked window, exec, hyprctl kill"
    "Super, V, ${d} Toggle floating, togglefloating"
    "Super, G, ${d} toggle group, togglegroup"
    "Shift, F11, ${d} toggle fullscreen, fullscreen"
    "Super, J, ${d} toggle split, togglesplit"
    "Super, L, ${d} lock screen, exec, hyprlock"
    # "Super Shift, F, ${d} toggle pin on focused window, exec, $scrPath/windowpin.sh"
    # "Control Alt, Delete, ${d} logout menu, exec, $scrPath/logoutlaunch.sh"
    # "Alt_R, Control_R, ${d} toggle waybar and reload config, exec, hyde-shell waybar --hide"
  ];

  groupNavigation = let
    d = "[Window Management|Group Navigation]";
  in [
    "Super Control, H, ${d} change active group backwards, changegroupactive, b"
    "Super Control, L, ${d} change active group forwards, changegroupactive, f"
  ];

  changeFocus = let
    d = "[Window Management|Change focus]";
  in [
    "Super, Left, ${d} focus left, movefocus, l"
    "Super, Right, ${d} focus right, movefocus, r"
    "Super, Up, ${d} focus up, movefocus, u"
    "Super, Down, ${d} focus down, movefocus, d"
    "ALT, Tab, ${d} Cycle focus, cyclenext"
  ];

  resizeActiveWindow = let
    d = "[Window Management|Resize Active Window]";
  in [
    "Super Alt Control, Right, ${d} resize window right, resizeactive, 30 0"
    "Super Alt Control, Left, ${d} resize window left, resizeactive, -30 0"
    "Super Alt Control, Up, ${d} resize window up, resizeactive, 0 -30"
    "Super Alt Control, Down, ${d} resize  window down, resizeactive, 0 30"
  ];

  moveActiveWindowWorkspace = let
    d = "[Window Management|Move Active Window Across Workspaces]";
    moveactivewindow = "grep -q \"true\" <<< $(hyprctl activewindow -j | jq -r .floating) && hyprctl dispatch moveactive";
  in [
    "Super Shift, left, ${d} Move active window to the left, exec, ${moveactivewindow} -30 0 || hyprctl dispatch movewindow l"
    "Super Shift, right, ${d} Move active window to the right, exec, ${moveactivewindow} 30 0 || hyprctl dispatch movewindow r"
    "Super Shift, up, ${d} Move active window up, exec, ${moveactivewindow}  0 -30 || hyprctl dispatch movewindow u"
    "Super Shift, down, ${d} Move active window down, exec, ${moveactivewindow} 0 30 || hyprctl dispatch movewindow d"
  ];

  moveResizeWithMouse = let
    d = "[Window Management|Move & Resize With Mouse]";
  in [
    "Super, mouse:272, ${d} hold to move window, movewindow"
    "Super, mouse:273, ${d} hold to resize window, resizewindow"
    "Super, Z, ${d} hold to move window, movewindow"
    "Super, X, ${d} hold to resize window, resizewindow"
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
    "Super, 1, ${d} navigate to workspace 1, workspace, 1"
    "Super, 2, ${d} navigate to workspace 2, workspace, 2"
    "Super, 3, ${d} navigate to workspace 3, workspace, 3"
    "Super, 4, ${d} navigate to workspace 4, workspace, 4"
    "Super, 5, ${d} navigate to workspace 5, workspace, 5"
    "Super, 6, ${d} navigate to workspace 6, workspace, 6"
    "Super, 7, ${d} navigate to workspace 7, workspace, 7"
    "Super, 8, ${d} navigate to workspace 8, workspace, 8"
    "Super, 9, ${d} navigate to workspace 9, workspace, 9"
    "Super, 0, ${d} navigate to workspace 10, workspace, 10"
    "Super Control, Down, ${d} navigate to the nearest empty workspace, workspace, empty"
    # Move focused window to a relative workspace
    "Super Control Shift, Right, ${d} move window to next relative workspace, movetoworkspace, r+1"
    "Super Control Shift, Left, ${d} move window to previous relative workspace, movetoworkspace, r-1"
    # Scroll through workspaces
    "Super, mouse_down, ${d} next workspace, workspace, e+1"
    "Super, mouse_up, ${d} previous workspace, workspace, e-1"
  ];

  workspaceRelativeNavigation = let
    d = "[Workspaces|Navigation|Relative workspace]";
  in [
    "Super Control, Left, ${d} change active workspace backwards, workspace, r-1"
    "Super Control, Right, ${d} change active workspace forwards, workspace, r+1"
  ];

  moveWindowToWorkspace = let
    d = "[Workspaces|Move Window To Workspace]";
  in [
    "Super Shift, 1, ${d} move to workspace 1, movetoworkspace, 1"
    "Super Shift, 2, ${d} move to workspace 2, movetoworkspace, 2"
    "Super Shift, 3, ${d} move to workspace 3, movetoworkspace, 3"
    "Super Shift, 4, ${d} move to workspace 4, movetoworkspace, 4"
    "Super Shift, 5, ${d} move to workspace 5, movetoworkspace, 5"
    "Super Shift, 6, ${d} move to workspace 6, movetoworkspace, 6"
    "Super Shift, 7, ${d} move to workspace 7, movetoworkspace, 7"
    "Super Shift, 8, ${d} move to workspace 8, movetoworkspace, 8"
    "Super Shift, 9, ${d} move to workspace 9, movetoworkspace, 9"
    "Super Shift, 0, ${d} move to workspace 10, movetoworkspace, 10"
  ];

  # Move/Switch to special workspace (scratchpad)
  moveSwitchSpecialWorkspace = let
    d = "[Workspaces|Navigation|Special Workspace]";
  in [
    "Super Shift, S, ${d} move to scratchpad, movetoworkspace, special"
    "Super Alt, S, ${d} move to scratchpad (silent), movetoworkspacesilent, special"
    "Super, S, ${d} toggle scratchpad,  togglespecialworkspace"
  ];

  moveWindowToWorkspaceSilent = let
    d = "[Workspaces|Navigation|Move window silently]";
  in [
    "Super Alt, 1, ${d} move to workspace 1  (silent), movetoworkspacesilent, 1"
    "Super Alt, 2, ${d} move to workspace 2  (silent), movetoworkspacesilent, 2"
    "Super Alt, 3, ${d} move to workspace 3  (silent), movetoworkspacesilent, 3"
    "Super Alt, 4, ${d} move to workspace 4  (silent), movetoworkspacesilent, 4"
    "Super Alt, 5, ${d} move to workspace 5  (silent), movetoworkspacesilent, 5"
    "Super Alt, 6, ${d} move to workspace 6  (silent), movetoworkspacesilent, 6"
    "Super Alt, 7, ${d} move to workspace 7  (silent), movetoworkspacesilent, 7"
    "Super Alt, 8, ${d} move to workspace 8  (silent), movetoworkspacesilent, 8"
    "Super Alt, 9, ${d} move to workspace 9  (silent), movetoworkspacesilent, 9"
    "Super Alt, 0, ${d} move to workspace 10 (silent), movetoworkspacesilent, 10"
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
