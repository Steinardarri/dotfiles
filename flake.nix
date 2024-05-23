{
  description = "Steinardarri's NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # disko = {
    #   url = "github:nix-community/disko";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # impermanence.url = "github:nix-community/impermanence";

    stylix.url = "github:danth/stylix";

    #nur.url = "github:nix-community/NUR";

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    nixos-hardware,
    #impermanence,
    stylix,
    ...
  }: let
    ############################################
    ## Define which host you want to use here ##
    ############################################
    inherit (import ./hosts/heima/options.nix) username hostname architecture;
  in {
    nixosConfigurations = {
      "${hostname}" = nixpkgs.lib.nixosSystem {
        system = architecture;
        specialArgs = {
          inherit inputs;
          inherit username;
          inherit hostname;
        };
        modules = [
          ./system.nix
          #impermanence.nixosModules.impermanence
          home-manager.nixosModules.home-manager
          stylix.nixosModules.stylix
          {
            home-manager.extraSpecialArgs = {
              inherit inputs;
              inherit username;
              inherit hostname;
            };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "backup";
            home-manager.users.${username} = import ./users/default/home.nix;
          }

          # Hardware Definitions
          # CPU
          nixos-hardware.nixosModules.common-cpu-amd
          nixos-hardware.nixosModules.common-cpu-amd-pstate
          nixos-hardware.nixosModules.common-cpu-amd-zenpower
          # GPU
          nixos-hardware.nixosModules.common-gpu-amd
          # Common
          nixos-hardware.nixosModules.common-pc
          nixos-hardware.nixosModules.common-pc-ssd
          nixos-hardware.nixosModules.common-pc-hdd
        ];
      };
    };
  };
}
