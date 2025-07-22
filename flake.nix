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
    hydenix,
    nix-vscode-extensions,
    determinate,
    self,
    ...
  } @ inputs: let
    genericModules = [
      {
        nixpkgs.overlays = [
          nix-vscode-extensions.overlays.default
        ];
      }

      {
        # This fixes things that don't use Flakes, but do want to use NixPkgs.
        nix.registry.nixos.flake = self;
        environment.etc."nix/inputs/nixpkgs".source = nixpkgs.outPath;
        nix.nixPath = ["nixpkgs=${nixpkgs.outPath}"];
      }

      determinate.nixosModules.default
    ];

    # https://lgug2z.com/articles/handling-secrets-in-nixos-an-overview/
    secrets = builtins.fromJSON (builtins.readFile "${self}/secrets/secrets.json");
  in {
    nixosConfigurations = {
      heima = hydenix.inputs.hydenix-nixpkgs.lib.nixosSystem {
        inherit (hydenix.lib) system;
        specialArgs = {
          inherit inputs;
          inherit secrets;
          username = "steinardth";
          hostname = "heima";
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
