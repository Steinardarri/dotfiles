{
  description = "Steinardarri's NixOS Configuration Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";

    hyprland = {
      url = "github:hyprwm/hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager,... } @ inputs: 
  let
    inherit (self) outputs;
    inherit (nixpkgs) lib;
    username = "steinardth";
    hostname = "nixos";
    specialArgs = { inherit inputs outputs username hostname nixpkgs; };
  in
  {
    nixosConfigurations = {

      lappi = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        hostname = "lappi";
        modules = [
          ./hosts
          ./hosts/lappi/configuration.nix
          inputs.home-manager.nixosModules {
            home-manager.extraSpecialArgs = specialArgs;
          }
        ];
      };

      wsl = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        username = "nixos";
        hostname = "wsl";
        modules = [
          ./hosts/wsl/configuration.nix
          inputs.home-manager.nixosModules {
            home-manager.extraSpecialArgs = specialArgs;
          }
        ];
      };

    };

    homeManagerModules.default = ./modules/homeManagerModules;
  };
}
