{pkgs, ...}: {
  programs.yazi = {
    enable = true;
    initLua = ./yaziInit.lua;
    plugins = {
      full-border = pkgs.yaziPlugins.full-border.yazi;
      git = pkgs.yaziPlugins.git.yazi;
      starship = pkgs.yaziPlugins.starship.yazi;
    };
    settings = {
      yazi = {
        mgr = {
          ratio = [1 3 3];
          sort_by = "natural";
          show_hidden = true;
          linemode = "size_and_mtime";
        };
        opener = {
          edit = [
            {
              run = "$EDITOR '$@'";
              desc = "$EDITOR";
              block = true;
              for = "unix";
            }
            {
              run = "sudo $EDITOR '$@'";
              desc = "sudo $EDITOR";
              block = true;
              for = "unix";
            }
          ];
        };

        input = {
          cursor_blink = true;
        };

        plugin.prepend_fetchers = [
          {
            id = "git";
            name = "*";
            run = "git";
          }
          {
            id = "git";
            name = "*/";
            run = "git";
          }
        ];
      };
      keymap = {
        input.prepend_keymap = [
          {
            on = "<Esc>";
            run = "close";
            desc = "Cancel input";
          }
        ];
      };
    };
  };
}
