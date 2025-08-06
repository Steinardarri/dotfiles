{
  inputs,
  pkgs,
  ...
}: {
  programs.hyprpanel = {
    enable = true;
    package = inputs.hyprpanel.packages.${pkgs.stdenv.hostPlatform.system}.default;

    # Not using other notification demons,
    # but the assertion won't pass
    dontAssertNotificationDaemons = true;

    settings = builtins.fromJSON (builtins.readFile ./config.json);
  };
}
