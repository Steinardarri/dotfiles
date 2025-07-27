{pkgs, ...}: {
  home.packages = with pkgs.kdePackages; [
    dolphin # KDE file manager
    dolphin-plugins
    qtimageformats # Image format support for Qt5
    ffmpegthumbs # Video thumbnail support
    kde-cli-tools # KDE command line utilities
    kdegraphics-thumbnailers # KDE graphics thumbnails
    kimageformats # Additional image format support for KDE
    qtsvg # SVG support
    kio # KDE I/O framework
    kio-extras # Additional KDE I/O protocols
    kwayland # KDE Wayland integration
  ];

  xdg.mimeApps = {
    defaultApplications = {
      "inode/directory" = ["org.kde.dolphin.desktop"];
      "x-scheme-handler/file" = ["org.kde.dolphin.desktop"];
      "x-scheme-handler/about" = ["org.kde.dolphin.desktop"];
    };
  };

  home.file.".config/dolphinrc".source = ./dolphinrc;
}
