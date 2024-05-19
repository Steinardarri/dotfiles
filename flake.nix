{
  description = "ZaneyOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";

    hyprland = {
      url = "github:hyprwm/hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";

    nur.url = "github:nix-community/NUR";

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    impermanence,
    ...
  }: let
    system = "x86_64-linux";

    hosts = [
      {
        hostname = "lappi";
        username = "steinardth";
      }
      {
        hostname = "vinna";
        username = "steinar";
      }
      {
        hostname = "heima";
        username = "steinardth";
      }
      {
        hostname = "vm";
        username = "steinardth";
      }
    ];

    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };

    configBuilder = {
      hostname,
      username,
    }: {
      name = hostname;
      value = {
        nixpkgs.lib.nixosSystem = {
          specialArgs = {
            inherit system;
            inherit inputs;
            inherit username;
            inherit hostname;
          };
          modules = [
            ./system.nix
            impermanence.nixosModules.impermanence
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = {
                inherit username;
                inherit inputs;
                inherit (inputs.nix-colors.lib-contrib {inherit pkgs;}) gtkThemeFromScheme;
              };
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.users.${username} = import ./users/default/home.nix;
            }
          ];
        };
      };
    };

    configs = builtins.map configBuilder hosts;
  in {
    nixosConfigurations = configs;
  };
}
