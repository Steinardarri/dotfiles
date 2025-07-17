{
  pkgs,
  inputs,
  ...
}: {
  programs.rio = {
    enable = true;
    package = inputs.rio.packages.${pkgs.stdenv.hostPlatform.system}.rio;

    settings = {
      # theme = "kanagawa";
      confirm-before-quit = false;
      padding-x = 10;
      padding-y = [15 10];
      cursor = {
        shape = "beam";
        blinking = true;
      };
      editor = {
        program = "$EDITOR";
        args = [];
      };
      fonts = {
        family = "Hack NF FC Ligatured CCG";
        size = 18;
        features = [];
        use-drawable-chars = true;
        symbol-map = [];
        disable-warnings-not-found = false;
        additional-dirs = [];
      };
      renderer = {
        target-fps = 144;
        filters = [
          # Loads built-in crt
          # "NewPixieCrt"
        ];
      };
      title = {
        content = "{{ TITLE || PROGRAM }} - {{ ABSOLUTE_PATH }}";
      };
      window = {
        opacity = 0.667;
        decorations = "enabled";
        blur = true;
      };
    };
  };
}
