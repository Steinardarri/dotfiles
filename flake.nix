{
  description = "Steinardarri's NixOS Config, from ZaneyOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors.url = "github:misterio77/nix-colors";

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    rose-pine-hyprcursor.url = "github:ndom91/rose-pine-hyprcursor";  

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
    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
      };
    };

    # define which host you want to use here
    inherit (import ./hosts/vm/options.nix) username hostname;
  in {
    nixosConfigurations = {
      "${hostname}" = nixpkgs.lib.nixosSystem {
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
              inherit hostname;
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
}
