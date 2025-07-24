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
        ../../modules/home

        # Nix-index-database - for comma and command-not-found
        inputs.nix-index-database.homeModules.nix-index
      ];
      
      # let home-manager control itself
      programs.home-manager.enable = true;

      ### Custom Modules From Import - to enable
      ###

      programs.git = {
        userName = "Steinar Darri Þorgilsson";
        userEmail = "steinar@steinardth.xyz";
      };

      home.sessionVariables = {
        EDITOR = "codium";
        VISUAL = "codium";
      };

      home.stateVersion = "25.05";
    };
  };
}
