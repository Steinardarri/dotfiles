{inputs, ...}: {
  # Disable the Home Manager module for now
  # It's not fresh
  disabledModules = ["programs/sherlock.nix"];

  imports = [
    inputs.sherlock.homeManagerModules.default
  ];

  programs.sherlock = {
    enable = true;
    runAsService = true;

    settings = {
      config = {
      };

      # fallback.json
      launchers = [
        {
          name = "Calculator";
          type = "calculation";
          args = {
            capabilities = [
              "calc.math"
              "calc.units"
            ];
          };
          priority = 1;
        }
        {
          name = "App Launcher";
          type = "app_launcher";
          args = {};
          priority = 2;
          home = "Home";
        }
      ];

      # sherlock_alias.json
      aliases = {
        equicord.name = "Discord";
      };

      # main.css
      style = ''
        * {
          font-family: sans-serif;
        }
      '';

      # sherlockignore
      ignore = ''
        Avahi*
        hicolor-icon-theme.desktop
        user-dirs.desktop
      '';
    };
  };
}
