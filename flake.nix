{
  description = "Steinardarri's NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
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
    # define which host you want to use here
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
          impermanence.nixosModules.impermanence
          home-manager.nixosModules.home-manager
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
        ];
      };
    };
  };
}
