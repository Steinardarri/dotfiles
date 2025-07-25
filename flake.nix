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

    nixos-facter-modules.url = "github:nix-community/nixos-facter-modules";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ### Desktop Environment ###

    stylix.url = "github:danth/stylix";

    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ### Misc Modules ###

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    hydenix,
    home-manager,
    nix-vscode-extensions,
    determinate,
    nur,
    disko,
    nixos-facter-modules,
    ...
  } @ inputs: let
    genericModules = [
      {
        # This fixes things that don't use Flakes, but do want to use NixPkgs.
        nix.registry.nixos.flake = self;
        environment.etc."nix/inputs/nixpkgs".source = nixpkgs.outPath;
        nix.nixPath = ["nixpkgs=${nixpkgs.outPath}"];
      }

      home-manager.nixosModules.home-manager
      {
        nix.registry.nixos.flake = inputs.self;
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.backupFileExtension = "hm-backup";
      }

      {
        nixpkgs.overlays = [
          nix-vscode-extensions.overlays.default
        ];
      }

      determinate.nixosModules.default

      nur.modules.nixos.default
    ];
  in {
    nixosConfigurations = {
      heima = let
        system = "x86_64-linux";
        username = "steinardth";
        hostname = "heima";

        # https://lgug2z.com/articles/handling-secrets-in-nixos-an-overview/
        secrets = builtins.fromJSON (builtins.readFile "./hosts/${hostname}/secrets/keys.json");
      in
        hydenix.inputs.hydenix-nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit inputs;
            inherit secrets;
            inherit username;
            inherit hostname;
          };

          modules =
            genericModules
            ++ [
              disko.nixosModules.default
              ./hosts/${hostname}/disko-config.nix

              nixos-facter-modules.nixosModules.facter
              {
                config.facter.reportPath = ./hosts/${hostname}/secrets/facter.json;
              }

              ./hosts/${hostname}

              {
                home-manager.extraSpecialArgs = {
                  inherit system;
                  inherit inputs;
                  inherit username;
                  inherit hostname;
                };
                home-manager.users.${username} = import ./hosts/${hostname}/home-configuration.nix;
              }
            ];
        };
    };
  };
}
