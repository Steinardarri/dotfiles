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
}
