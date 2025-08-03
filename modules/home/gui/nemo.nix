{pkgs, ...}: {
  home.packages = with pkgs; [
    (nemo-with-extensions.override {
      extensions = [
        nemo-preview
        nemo-emblems
        nemo-python
        nemo-qml-plugin-dbus
      ];
    })
  ];

  xdg.desktopEntries.nemo = {
    name = "Nemo";
    exec = "${pkgs.nemo-with-extensions}/bin/nemo";
  };
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = ["nemo.desktop"];
      "application/x-gnome-saved-search" = ["nemo.desktop"];
    };
  };

  dconf = {
    settings = {
        "org/cinnamon/desktop/applications/terminal" = {
            exec = "kitty";
            # exec-arg = ""; # argument
        };
    };
};
}
