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
      ];

      # Let home-manager control itself
      programs.home-manager.enable = true;
      home.username = "${username}";
      home.homeDirectory = "/home/${username}";

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
    };
  };
}
