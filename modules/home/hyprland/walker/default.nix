{inputs, ...}: {
  # https://github.com/abenz1267/walker/blob/master/nix/modules/home-manager.nix
  imports = [
    inputs.walker.homeManagerModules.default
  ];

  programs.walker = {
    enable = true;
    runAsService = true;
    config = builtins.fromTOML (builtins.readFile ./config.toml);
    # theme = {};
  };
}
