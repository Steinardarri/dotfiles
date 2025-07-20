{inputs, ...}: let
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
  username = "steinardth";
in {
  # Set pkgs for hydenix globally, any file that imports pkgs will use this
  nixpkgs.pkgs = pkgs;

  imports = [
    # Hardware Modules
    ./hardware-configuration.nix
    inputs.hydenix.inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.hydenix.inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.hydenix.inputs.nixos-hardware.nixosModules.common-pc
    inputs.hydenix.inputs.nixos-hardware.nixosModules.common-pc-ssd

    # System Modules
    inputs.hydenix.lib.nixOsModules
    ../../modules/system

    # Home Manager Modules
    inputs.hydenix.inputs.home-manager.nixosModules.home-manager
    ./home-configuration.nix
  ];

  _homeConfig.username = "${username}";

  ### Custom Modules From Import - to enable

  _gaming.enable = true;

  hydenix = {
    hostname = "heima";
    gaming.enable = true;
  };

  users = {
    users.${username} = {
      isNormalUser = true;
      homeMode = "755";
      hashedPasswordFile = "/etc/hashedUserPasssword";
      description = "Steinar Darri Þorgilsson";
      extraGroups = [
        "wheel"
        "networkmanager"
        "video"
      ];
      shell = pkgs.fish;
      # ignoreShellProgramCheck = true;
    };

    mutableUsers = false;
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "${username}";
  # Whether you need to input password on sudo
  security.sudo.wheelNeedsPassword = false;

  system.stateVersion = "25.05";
}
