{pkgs, ...}: {
  imports = [
    ./files
    ./shell
  ];

  home.packages = with pkgs; [
    gimp3-with-plugins
    element-desktop
    logseq

    krita
    qalculate-qt
  ];
}
