{
  description = "Steinardarri's Home Manager Config";

  outputs = {
    nixpkgs,
    nixpkgs-codiumpin,
    home-manager,
    nix-vscode-extensions,
    ...
  } @ inputs: {
    homeConfigurations = let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs'' = import nixpkgs-codiumpin {
        inherit system;
        config.allowUnfree = true;
        overlays = [
          nix-vscode-extensions.overlays.default
        ];
      };
    in {
      "steinardth" = let
        username = "steinardth";
      in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          extraSpecialArgs = {
            inherit inputs;
            inherit system;
            inherit username;
          };

          modules = [
            {
              ### Custom Modules From modules/home - to enable
              ###

              nixpkgs.overlays = [
                (final: prev: {
                  nix-vscode-extensions = pkgs''.nix-vscode-extensions;
                })
              ];

              home = {
                inherit username;
                homeDirectory = "/home/${username}";
                sessionVariables = {
                  EDITOR = "nano";
                  VISUAL = "codium";
                };
              };

              programs.git.settings.user = {
                name = "Steinar Darri Þorgilsson";
                email = "steinar@steinardth.xyz";
              };
            }

            ./modules
          ];
        };
    };
  };

  inputs = {
    ### System ###
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-codiumpin.url = "github:NixOS/nixpkgs/f997fa0f94fb1ce55bccb97f60d41412ae8fde4c";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ### Program Modules ###

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
