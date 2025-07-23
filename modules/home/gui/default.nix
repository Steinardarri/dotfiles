{pkgs, ...}: {
  imports = [
    ./dolphin
    ./vscodium
    ./zen-browser

    ./kitty.nix
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
