{pkgs, ...}: {
  home.packages = with pkgs; [
    libsForQt5.qt5ct
    libsForQt5.qt5.qtbase
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qtimageformats
    libsForQt5.qtsvg
    libsForQt5.qt5.qtwayland
    kdePackages.qt6ct
    kdePackages.qtbase
    kdePackages.qtwayland
    kdePackages.qtstyleplugin-kvantum
    kdePackages.qtimageformats
    kdePackages.qtsvg
    kdePackages.qtwayland
  ];

  home.sessionVariables = {
    QT_AUTO_SCREEN_SCALE_FACTOR = "1"; # (From the Qt documentation) enables automatic scaling, based on the monitor’s pixel density
    QT_QPA_PLATFORM = "wayland"; # Tell Qt applications to use the Wayland backend
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1"; # Disables window decorations on Qt applications
  };
}
