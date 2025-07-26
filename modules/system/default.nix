{
  pkgs,
  username,
  ...
}: {
  imports = [
    ./boot
    ./drivers
    ./programs
    ./services

    ./audio.nix
    ./boot.nix
    ./locale.nix
    ./packages.nix
    ./system.nix
  ];

  time.timeZone = "Atlantic/Reykjavik";

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
      download-buffer-size = 524288000;
      max-jobs = 4;
      cores = 4;
      show-trace = false;
    };
    substituters = [
      "https://install.determinate.systems"
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
    ];
    trusted-public-keys = [
      "cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };
  nixpkgs.config.allowUnfree = true;

  environment.variables = {
    FLAKE = "/home/${username}/dotfiles";
    SHELL = "/etc/profiles/per-user/${username}/bin/fish";
    NIXOS_OZONE_WL = "1";
  };

  fonts = {
    packages = with pkgs; [
      nerd-fonts.hack
    ];
    fontDir.enable = true;
  };

  system.stateVersion = "25.05";
}
