{pkgs, ...}: {
  imports = [
    ./vscodium
    ./zen-browser
  ];

  home.packages = with pkgs; [
    gimp3-with-plugins
    element-desktop
    logseq
    protonvpn-gui

    krita
    qalculate-qt
    haruna
  ];
}
