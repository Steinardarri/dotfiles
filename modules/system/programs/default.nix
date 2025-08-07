{...}: {
  imports = [
    ./gaming.nix
    ./nano.nix
    ./thunar.nix
  ];

  programs = {
    partition-manager.enable = true;
    direnv = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
  };
}
