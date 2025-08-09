{
  # enables the plugin
  enabled = true;

  # sets the cursor behaviour, supports these values:
  # tilt    - tilt the cursor based on x-velocity
  # rotate  - rotate the cursor based on movement direction
  # stretch - stretch the cursor shape based on direction and velocity
  # none    - do not change the cursors behaviour
  mode = "stretch";

  # minimum angle difference in degrees after which the shape is changed
  # smaller values are smoother, but more expensive for hw cursors
  threshold = 2;

  # for mode = stretch
  stretch = {
    # controls how much the cursor is stretched
    # this value controls at which speed (px/s) the full stretch is reached
    # the full stretch being twice the original length
    limit = 3000;

    # relationship between speed and stretch amount, supports these values:
    # linear             - a linear function is used
    # quadratic          - a quadratic function is used
    # negative_quadratic - negative version of the quadratic one, feels more aggressive
    # see `activation` in `src/mode/utils.cpp` for how exactly the calculation is done
    function = "quadratic";

    # time window (ms) over which the speed is calculated
    # higher values will make slow motions smoother but more delayed
    window = 100;
  };

  # use hyprcursor to get a higher resolution texture when the cursor is magnified
  # see the `hyprcursor` section below
  hyprcursor = {
    # use nearest-neighbour (pixelated) scaling when magnifing beyond texture size
    # this will also have effect without hyprcursor support being enabled
    # 0 / false - never use pixelated scaling
    # 1 / true  - use pixelated when no highres image
    # 2         - always use pixleated scaling
    nearest = true;

    # enable dedicated hyprcursor support
    enabled = true;

    # resolution in pixels to load the magnified shapes at
    # be warned that loading a very high-resolution image will take a long time and might impact memory consumption
    # -1 means we use [normal cursor size] * [shake:base option]
    resolution = -1;

    # shape to use when clientside cursors are being magnified
    # see the shape-name property of shape rules for possible names
    # specifying clientside will use the actual shape, but will be pixelated
    fallback = "clientside";
  };
}
