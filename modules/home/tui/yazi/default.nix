{
  pkgs,
  config,
  ...
}: {
  programs.yazi = {
    enable = true;
    initLua = ./yaziInit.lua;
    enableFishIntegration = true;
    shellWrapperName = "yy";
    plugins = {
      inherit (pkgs.yaziPlugins) full-border;
      inherit (pkgs.yaziPlugins) starship;
      inherit (pkgs.yaziPlugins) toggle-pane;
    };
    settings = {
      mgr = {
        ratio = [1 3 3];
        sort_by = "natural";
        sort_sensitive = false;
        sort_reverse = false;
        sort_dir_first = true;
        show_hidden = true;
        show_symlink = true;
        linemode = "size_and_mtime";
        scrolloff = 150;
      };

      preview = {
        wrap = "yes";
        tab_size = 2;
        image_filter = "lanczos3";
        max_width = 600;
        max_height = 900;
        image_quality = 90;
        cache_dir = config.xdg.cacheHome;
      };

      opener = {
        edit = [
          {
            run = "$EDITOR \"$@\"";
            desc = "$EDITOR";
            block = true;
            for = "unix";
          }
          {
            run = "sudo $EDITOR \"$@\"";
            desc = "sudo $EDITOR";
            block = true;
            for = "unix";
          }
        ];
        play = [
          {
            run = "mpv \"$@\"";
            orphan = true;
            for = "unix";
          }
        ];
      };

      input = {
        cursor_blink = true;
      };
    };

    keymap = {
      input.prepend_keymap = [
        {
          on = "<Esc>";
          run = "close";
          desc = "Cancel input";
        }
      ];
      mgr.prepend_keymap = [
        {
          on = "T";
          run = "plugin toggle-pane max-preview";
          desc = "Maximize or restore the preview pane";
        }
      ];
    };
  };
}
