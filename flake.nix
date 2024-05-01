{
  description = "Steinardarri NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    inputs.nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    nix-colors.url = "github:misterio77/nix-colors";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    ...
  } @ inputs: let
    inherit (self) outputs;
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      lappi = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [ ./hosts ./hosts/lappi/configuration.nix ];
      };

      heima = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [ ./hosts .hosts/heima/configuration.nix ];
      };

      brennisteinn = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [ ./hosts .hosts/brennisteinn/configuration.nix ];
      };
    };
  };
}
