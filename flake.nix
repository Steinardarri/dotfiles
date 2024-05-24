{
  description = "Steinardarri's NixOS Config";

  inputs = {
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

    #plasma-manager = "github:pjones/plasma-manager/plasma-5";

    impermanence.url = "github:nix-community/impermanence";

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
    impermanence,
    disko,
    stylix,
    ...
  }: let
    ############################################
    ## Define which host you want to use here ##
    ############################################
    inherit (import ./hosts/heima/options.nix) username hostname architecture device hardware-list;
    hardware-import = list: map (item: nixos-hardware.nixosModules.${item}) list;
  in {
    nixosConfigurations = {
      "${hostname}" = nixpkgs.lib.nixosSystem {
        system = architecture;
        specialArgs = {
          inherit inputs;
          inherit username;
          inherit hostname;
          inherit device;
        };
        modules = [
          ./configuration.nix
          impermanence.nixosModules.impermanence
          disko.nixosModules.default
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
            home-manager.users.${username} = import ./users/home.nix;
          }
        ] ++ hardware-import hardware-list;
      };
    };
  };
}
