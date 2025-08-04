{pkgs, ...}: {
  imports = [./cinnamon-desktop-editor.nix];
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
    # Metadata
    tinysparql
    localsearch
    # For MTP support (Android devices)
    simple-mtpfs
    libmtp
  ];

  xdg.desktopEntries.nemo = {
    name = "Nemo";
    exec = "${pkgs.nemo-with-extensions}/bin/nemo";
  };
  xdg.mimeApps = {
    defaultApplications = {
      "inode/directory" = "nemo.desktop";
      "application/x-gnome-saved-search" = "nemo.desktop";
    };
  };

  dconf = {
    settings = {
      "org/cinnamon/desktop/applications/terminal" = {
        exec = "kitty";
        exec-arg = "--hold fish -c";
      };
    };
  };

  dbus.packages = with pkgs; [
    libcryptui
  ];
}
