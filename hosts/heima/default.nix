{
  inputs,
  username,
  hostname,
  secrets,
  ...
}: let
  # Package declaration
  # ---------------------
  pkgs = import inputs.hydenix.inputs.hydenix-nixpkgs {
    inherit (inputs.hydenix.lib) system;
    config.allowUnfree = true;
    overlays = [
      inputs.hydenix.lib.overlays
      (final: prev: {
        userPkgs = import inputs.nixpkgs {
          config.allowUnfree = true;
        };
      })
    ];
  };
in {
  # Set pkgs for hydenix globally, any file that imports pkgs will use this
  nixpkgs.pkgs = pkgs;

  hydenix.hostname = "${hostname}";

  imports = [
    # Hardware Modules
    ./hardware-configuration.nix
    ./extra-hardware.nix
    inputs.hydenix.inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.hydenix.inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.hydenix.inputs.nixos-hardware.nixosModules.common-pc
    inputs.hydenix.inputs.nixos-hardware.nixosModules.common-pc-ssd

    # System Modules
    inputs.hydenix.lib.nixOsModules
    ../../modules/system
  ];

  ### Custom System Modules From Import - to enable

  _amd_gpu.enable = true;
  _gaming.enable = true;
  _jellyfin.enable = true;
  _flatpak.enable = true;
  _torrent.enable = true;

  ###

  users = {
    users.${username} = {
      isNormalUser = true;
      homeMode = "755";
      # Secrets handled by git-crypt, from flake input
      hashedPassword = "${secrets.hashed_user_password}";
      description = "Steinar Darri Þorgilsson";
      extraGroups = [
        "wheel"
        "networkmanager"
        "video"
      ];
      shell = pkgs.fish;
    };
    mutableUsers = false;
  };

  services.displayManager = {
    autoLogin.enable = true;
    autoLogin.user = "${username}";
  };

  # Whether you need to input password on sudo
  security.sudo.wheelNeedsPassword = true;

  system.stateVersion = "25.05";
}
