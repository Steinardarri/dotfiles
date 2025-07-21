{
  description = "Steinardarri's Hydenix NixOS config";

  inputs = {
    # User's nixpkgs - for user packages
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0";

    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";

    # Hydenix and its nixpkgs - kept separate to avoid conflicts
    hydenix.url = "github:richen604/hydenix";

    # Nix-index-database - for comma and command-not-found
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    determinate,
    ...
  } @ inputs: let
    genericModules = [
      {
        nixpkgs.overlays = [
          inputs.nix-vscode-extensions.overlays.default
        ];
      }

      {
        # This fixes things that don't use Flakes, but do want to use NixPkgs.
        nix.registry.nixos.flake = inputs.self;
        environment.etc."nix/inputs/nixpkgs".source = nixpkgs.outPath;
        nix.nixPath = ["nixpkgs=${nixpkgs.outPath}"];
      }

      determinate.nixosModules.default
    ];
  in {
    nixosConfigurations = {
      heima = inputs.hydenix.inputs.hydenix-nixpkgs.lib.nixosSystem {
        inherit (inputs.hydenix.lib) system;
        specialArgs = {
          inherit inputs;
        };
        modules =
          genericModules
          ++ [
            ./hosts/heima
          ];
      };
    };
  };
}
