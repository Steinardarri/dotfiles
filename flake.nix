{
  description = "Steinardarri's Home Manager Config";

  outputs = {
    nixpkgs,
    home-manager,
    nix-vscode-extensions,
    ...
  } @ inputs: {
    homeConfigurations = let
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
        overlays = [ inputs.nix-vscode-extensions.overlays.default ];
      };    
    in {
      "steinardth" = let
        username = "steinardth";
        hostname = "heima";
      in
        home-manager.lib.homeManagerConfiguration {
          inherit pkgs;

          extraSpecialArgs = {
            inherit inputs;
            inherit system;
            inherit username;
            inherit hostname;
          };

          modules = [
            {
              ### Custom Modules From modules/home - to enable
              ###

              home = {
                inherit username;
                homeDirectory = "/home/${username}";
                sessionVariables = {
                  EDITOR = "nano";
                  VISUAL = "codium";
                };
              };

              programs.git = {
                userName = "Steinar Darri Þorgilsson";
                userEmail = "steinar@steinardth.xyz";
              };
            }

            ./modules
          ];
        };
    };
  };

  inputs = {
    ### System ###
    nixpkgs.url = "nixpkgs/nixos-unstable";

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
