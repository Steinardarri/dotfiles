{
  description = "Steinardarri's NixOS Config";

  inputs = {
    
    # System
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Desktop Environment
    plasma-manager = {
      #url = "github:pjones/plasma-manager/plasma-5";
      url = "github:pjones/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    stylix.url = "github:danth/stylix";

    # Misc Modules
    nur.url = "github:nix-community/NUR";

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:the-argus/spicetify-nix";
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    nixos-hardware,
    disko,
    stylix,
    ...
  }: let
    ############################################
    ## Define which host you want to use here ##
    ############################################
    inherit (import ./hosts/heima/options.nix) username hostname system device swap hardware-list;

    hardware-import = list: map (item: nixos-hardware.nixosModules.${item}) list;

    genericModules = [
      home-manager.nixosModules.home-manager
      stylix.nixosModules.stylix

      {
        nix.registry.nixos.flake = inputs.self;
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "hm-backup";
        home-manager.extraSpecialArgs = {
          inherit system;
          inherit inputs;
          inherit username;
          inherit hostname;
        };
      }

      {
        # This fixes things that don't use Flakes, but do want to use NixPkgs.
        nix.registry.nixos.flake = inputs.self;
        environment.etc."nix/inputs/nixpkgs".source = nixpkgs.outPath;
        nix.nixPath = ["nixpkgs=${nixpkgs.outPath}"];
      }
    ];
  in {
    nixosConfigurations = {
      "${hostname}" = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs;
          inherit username;
          inherit hostname;
          inherit device;
          inherit swap;
        };

        modules =
          genericModules
          ++ [
            ./configuration.nix
            ./disko.nix

            disko.nixosModules.default

            {
              home-manager.users.${username} = import ./users/home.nix;
            }

            {
              nixpkgs.overlays = [
                inputs.nix-vscode-extensions.overlays.default
              ];
            }
          ]
          ++ hardware-import hardware-list;
      };
    };
  };
}
