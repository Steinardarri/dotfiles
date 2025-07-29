{pkgs, ...}: {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        layer = "overlay";
        terminal = "${pkgs.kitty}/bin/kitty";
        launch-prefix = "uwsm app -- ";
      };
    };
  };
}
