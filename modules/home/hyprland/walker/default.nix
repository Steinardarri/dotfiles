{inputs, lib, ...}: {
  # https://github.com/abenz1267/walker/blob/master/nix/modules/home-manager.nix
  imports = [
    inputs.walker.homeManagerModules.default
  ];

  programs.walker = {
    enable = true;
    runAsService = true;
    # config = {};
    # theme = {};
  };

  home.file = {
    ".config/walker/config.toml".source = lib.mkForce ./config.toml;
  };
}
