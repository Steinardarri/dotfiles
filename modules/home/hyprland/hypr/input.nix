"
# █ █▄░█ █▀█ █░█ ▀█▀
# █ █░▀█ █▀▀ █▄█ ░█░

# https://wiki.hypr.land/Configuring/Variables/#input

input {
    # Keyboard
    numlock_by_default = true
    kb_model = pc105
    kb_layout = is
    kb_options = caps:hyper, fkeys:basic_13-24
    repeat_rate = 35
    repeat_delay = 250

    # Mouse
    sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
    accel_profile = flat
    follow_mouse = 1
    float_switch_override_focus = 2

    touchpad {
        natural_scroll = true
    }
}

# https://wiki.hypr.land/Configuring/Variables/#gestures

gestures {
    workspace_swipe = true
    workspace_swipe_distance = 700
    workspace_swipe_fingers = 3
    workspace_swipe_min_fingers = true
    workspace_swipe_cancel_ratio = 0.2
    workspace_swipe_min_speed_to_force = 5
    workspace_swipe_direction_lock = true
    workspace_swipe_direction_lock_threshold = 10
    workspace_swipe_create_new = true
}

"
