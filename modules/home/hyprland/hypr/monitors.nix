"
# █▀▄▀█ █▀█ █▄░█ █ ▀█▀ █▀█ █▀█ █▀
# █░▀░█ █▄█ █░▀█ █ ░█░ █▄█ █▀▄ ▄█

# https://wiki.hypr.land/Configuring/Monitors/

monitor = DP-1, 2560x1440@144, 0x0, 1
monitor = DP-2, 1920x1080@144, -1920x0, 1
monitor = , preferred, auto, 1

xwayland {
 force_zero_scaling = true   # Unscale XWayland
}

# https://wiki.hypr.land/Configuring/Variables/#misc
misc {
  vfr = 1
  vrr = 1
  mouse_move_enables_dpms = true
  key_press_enables_dpms = true
}

"
