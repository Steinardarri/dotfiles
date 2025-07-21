{
  lib,
  config,
  inputs,
  ...
}: {
  options._homeConfig.username = lib.mkOption {
    type = lib.types.str;
    description = "Username for home-manager";
  };

  config = {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "hm-backup";
      extraSpecialArgs = {
        inherit inputs;
      };

      users."${toString config._homeConfig.username}" = {
        imports = [
          inputs.hydenix.lib.homeModules
          ../../modules/home

          # Nix-index-database - for comma and command-not-found
          inputs.nix-index-database.homeModules.nix-index
        ];

        # Custom Modules From Import - to enable
        _torrent.enable = true;

        hydenix.hm = {
          git = {
            name = "Steinar Darri Þorgilsson";
            email = "steinar@steinardth.xyz";
          };
        };
      };
    };
  };
}
