{pkgs, ...}: {
  stylix = {
    icons = {
      enable = true;
      package = pkgs.nordzy-icon-theme;
      dark = "Nordzy";
      light = "Nordzy";
    };
  };

  # Stylix doesn't handle hyprcursor for now
  home.pointerCursor = {
    enable = true;

    package = pkgs.nordzy-cursor-theme;
    name = "Nordzy-cursors";
    size = 24;

    hyprcursor = {
      enable = true;
      size = 24;
    };

    dotIcons.enable = true;
    gtk.enable = true;
  };
}
