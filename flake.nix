{
  description = "Steinardarri's NixOS Config";

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nix-vscode-extensions,
    # nur,
    disko,
    nixos-facter-modules,
    stylix,
    hyprutils,
    ...
  } @ inputs: let
    genericModules = [
      # Overlays
      {
        nixpkgs.overlays = [
          nix-vscode-extensions.overlays.default
          hyprutils.overlays.default
        ];
      }

      {
        # This fixes things that don't use Flakes, but do want to use NixPkgs.
        nix.registry.nixos.flake = self;
        environment.etc."nix/inputs/nixpkgs".source = nixpkgs.outPath;
        nix.nixPath = ["nixpkgs=${nixpkgs.outPath}"];
      }

      home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "hm-backup";
        };
      }

      # nur.modules.nixos.default

      stylix.nixosModules.stylix
    ];
  in {
    nixosConfigurations = {
      heima = let
        system = "x86_64-linux";
        username = "steinardth";
        hostname = "heima";
        KBDLayout = "is";
        stylixTheme = "dystopia";
        hyprlandMonitors = [
          "DP-1, 2560x1440@144, 0x0       , 1.0"
          "DP-2, 1920x1080@144, -1920x360, 1.0"
          "    , preferred    , auto      , 1.0"
        ];
        hyprlandWorkspaces = [
          "1, monitor:DP-1, default:true"
          "2, monitor:DP-1"
          "3, monitor:DP-1"
          "4, monitor:DP-2, default:true"
          "5, monitor:DP-2"
          "6, monitor:DP-2"
        ];

        # https://lgug2z.com/articles/handling-secrets-in-nixos-an-overview/
        secrets = builtins.fromJSON (builtins.readFile ./hosts/${hostname}/secrets/keys.json);
      in
        nixpkgs.lib.nixosSystem {
          inherit system;

          specialArgs = {
            inherit inputs;
            inherit username;
            inherit hostname;
            inherit secrets;
            inherit stylixTheme;
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
              ./modules/system
              ./modules/stylix

              {
                home-manager = {
                  extraSpecialArgs = {
                    inherit inputs;
                    inherit system;
                    inherit username;
                    inherit hostname;
                    inherit KBDLayout;
                    inherit stylixTheme;
                    inherit hyprlandMonitors;
                    inherit hyprlandWorkspaces;
                    inherit secrets;
                  };
                  users.${username} = {
                    imports = [
                      ./hosts/${hostname}/home-configuration.nix
                      ./modules/home
                      ./modules/stylix/home.nix
                    ];
                  };
                };
              }
            ];
        };
    };
  };

  inputs = {
    ### System ###
    nixpkgs.url = "nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "nixpkgs/nixos-25.05";
    systems.url = "github:nix-systems/default-linux";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-facter-modules.url = "github:nix-community/nixos-facter-modules";

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nur = {
    #   url = "github:nix-community/NUR";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    ### Desktop Environment ###

    stylix = {
      url = "github:danth/stylix";
      inputs = {
        # flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };

    hyprland = {
      url = "github:hyprwm/Hyprland";
      # Overriding the nixpkgs input may
      # disable Cachix
      # inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprutils = {
      url = "github:hyprwm/hyprutils";
    };

    ### Program Modules ###

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    walker = {
      url = "github:abenz1267/walker/v0.13.13";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
