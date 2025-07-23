{
  inputs,
  secrets,
  username,
  ...
}: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm-backup";
    extraSpecialArgs = {
      inherit inputs;
      inherit secrets;
      inherit username;
    };

    users."${username}" = {
      imports = [
        inputs.hydenix.lib.homeModules
        ../../modules/home

        # Nix-index-database - for comma and command-not-found
        inputs.nix-index-database.homeModules.nix-index
      ];

      # Custom Modules From Import - to enable
      _torrent.enable = true;

      programs.git = {
        userName = "Steinar Darri Þorgilsson";
        userEmail = "steinar@steinardth.xyz";
      };

      home.sessionVariables = {
        EDITOR = "codium";
        VISUAL = "codium";
      };
    };
  };
}
