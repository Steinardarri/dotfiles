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

  hydenix = {
    hardware.enable = true;
    sddm = {
      enable = true;
      theme = "Candy"; # Candy, Corners
    };
  };

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
    ];
    trusted-public-keys = [
      "cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
  nixpkgs.config.allowUnfree = true;

  programs = {
    nh = {
      enable = true;
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep-since 14d --keep 10";
      };
      flake = "/home/${username}/dotfiles";
    };
    fish.enable = true;
  };

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

  # Catppuccin Mocha Color Scheme For TTY Console
  console = {
    colors = [
      # 0-7 normal
      "11111b"
      "f38ba8"
      "a6e3a1"
      "f9e2af"
      "89b4fa"
      "f5c2e7"
      "94e2d5"
      "a6adc8"
      # 8-15 bright
      "6c7086"
      "eba0ac"
      "a6e3a1"
      "fab387"
      "74c7ec"
      "cba6f7"
      "89dceb"
      "cdd6f4"
    ];
  };

  # Regist appimage-run as the executor of appimages
  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };

  system.stateVersion = "25.05";
}
