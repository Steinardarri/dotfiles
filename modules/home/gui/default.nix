{pkgs, ...}: {
  imports = [
    ./dolphin
    ./equibop
    ./vscodium
    ./zen-browser

    ./kitty.nix
    ./lapce.nix
    ./torrent.nix
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
    kdePackages.kgpg
    kdePackages.okular

    # Add kwallet pam service later
    kdePackages.kwallet
    kdePackages.kwalletmanager

    # LibreOffice
    libreoffice-qt6-fresh
    hunspell
    hunspellDicts.en_GB-large
  ];
}
