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
    ../../hosts

    inputs.hydenix.inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix

    inputs.hydenix.lib.nixOsModules
    ./modules/system

    inputs.hydenix.inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.hydenix.inputs.nixos-hardware.nixosModules.common-cpu-amd
    inputs.hydenix.inputs.nixos-hardware.nixosModules.common-pc
    inputs.hydenix.inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  hydenix = {
    enable = true; # Enable the Hydenix module

    hostname = "heima";

    audio.enable = true; # enable audio module
    boot = {
      enable = true; # enable boot module
      useSystemdBoot = false; # disable for GRUB
      grubTheme = "Retroboot"; # or "Pochita"
      grubExtraConfig = ""; # additional GRUB configuration
      kernelPackages = pkgs.linuxPackages_zen; # default zen kernel
    };
    gaming.enable = true; # enable gaming module
    hardware.enable = true; # enable hardware module
    network.enable = true; # enable network module
    nix.enable = true; # enable nix module
    sddm = {
      enable = false; # enable sddm module
      theme = "Candy"; # or "Corners"
    };
    system.enable = true; # enable system module
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

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
    };

    users."${username}" = {...}: {
      imports = [
        inputs.hydenix.lib.homeModules
        # Nix-index-database - for comma and command-not-found
        inputs.nix-index-database.homeModules.nix-index
        ./modules/hm
      ];
    };
  };

  system.stateVersion = "25.05";
}
