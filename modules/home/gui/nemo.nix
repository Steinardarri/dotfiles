{pkgs, ...}: {
  home.packages = with pkgs; [
    (nemo-with-extensions.override {
      extensions = [
        nemo-preview
        nemo-emblems
        nemo-fileroller
        nemo-seahorse
        nemo-python
        nemo-qml-plugin-dbus
      ];
    })

    # cinnamon-desktop-editor
    # Metadata
    tracker
    tracker-miners
    # For MTP support (Android devices)
    simple-mtpfs
    libmtp
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

  dbus.packages = with pkgs; [
    libcryptui
  ];
}
