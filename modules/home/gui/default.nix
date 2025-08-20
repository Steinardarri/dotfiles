{pkgs, ...}: {
  imports = [
    ./discord.nix
    ./kitty.nix
    ./mpv.nix
    ./spotify.nix
    ./torrent.nix
    ./vscodium.nix
    ./zen-browser.nix
  ];

  home.packages = with pkgs; [
    gimp3-with-plugins
    element-desktop
    logseq
    protonvpn-gui
    ungoogled-chromium
    grsync
    dbeaver-bin

    # GNOME
    baobab
    evince

    # xfce
    xfce.ristretto
    xfce.mousepad

    # KDE stuff
    krita
    qalculate-qt
    kdePackages.kdenlive
    okteta

    # LibreOffice
    libreoffice-qt6-fresh
    hunspell
    hunspellDicts.en_GB-large
  ];
}
