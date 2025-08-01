{pkgs, ...}: {
  home.packages = with pkgs; [
    equibop
  ];
  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/discord" = "equibop.desktop";
  };
  # TODO: Custom File Import Stuff
}
