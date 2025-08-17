_: {
  programs.sherlock = {
    enable = false;
    systemd.enable = false;

    settings = {
      config = {
        theme = "dark";
        width = 500;
        max_results = 10;
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
