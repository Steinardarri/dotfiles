{pkgs, ...}: {
  imports = [
    ./nemo

    ./discord.nix
    ./kitty.nix
    ./lapce.nix
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
    baobab
    evince

    # KDE stuff
    krita
    qalculate-qt
    kdePackages.kdenlive

    # LibreOffice
    libreoffice-qt6-fresh
    hunspell
    hunspellDicts.en_GB-large
  ];
}
