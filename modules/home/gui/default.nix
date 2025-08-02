{pkgs, ...}: {
  imports = [
    ./dolphin
    ./vscodium

    ./discord.nix
    ./kitty.nix
    ./lapce.nix
    ./torrent.nix
    ./zen-browser.nix
  ];

  home.packages = with pkgs; [
    gimp3-with-plugins
    element-desktop
    logseq
    protonvpn-gui
    ungoogled-chromium
    grsync

    # KDE stuff
    krita
    qalculate-qt
    haruna

    kdePackages.filelight
    kdePackages.kdenlive
    kdePackages.okular

    # LibreOffice
    libreoffice-qt6-fresh
    hunspell
    hunspellDicts.en_GB-large

    # Nemo
    (nemo-with-extensions.override {
      extensions = [
        nemo-preview
        nemo-emblems
        nemo-python
        nemo-qml-plugin-dbus
      ];
    })
  ];
}
