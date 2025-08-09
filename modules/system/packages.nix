{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    bash

    # core languages
    gcc
    nodejs
    zig
    # rust stuff
    cargo-cache
    cargo-expand
    cargo-leptos
    rustup
    trunk

    # dev stuf
    cmake
    httpie
    ninja
    tree-sitter

    # language servers
    # ccls # c / c++
    nixd # nix
    # nodePackages.yaml-language-server
    # nodePackages.vscode-langservers-extracted # html, css, json, eslint

    # formatters & linters
    alejandra # nix formatter
    nixfmt # nix formatter
    statix # nix linter
    nodePackages.prettier
    shellcheck
    shfmt
    ruff # python

    # security
    git-crypt

    # media
    imagemagick
    yt-dlg
    ffmpeg
    inkscape

    # utils
    bat
    bottom
    broot
    btop
    clinfo
    coreutils
    curl
    deadnix
    du-dust
    eza
    fd
    findutils
    fx
    fzf
    helix
    lshw
    mosh
    nvd
    p7zip
    parallel
    pinentry-all
    pkg-config
    procs
    ripgrep
    sd
    tldr
    tree
    wget
    wormhole-william
    yazi
    zoxide

    # for fun
    cmatrix
    cowsay
    lolcat
    notcurses
    fastfetch

    # ui & looks
    yad
    grc
    nix-output-monitor
    atuin
    starship

    # hardware
    brightnessctl # screen brightness control
    udiskie # manage removable media
    ntfs3g # ntfs support
    exfat # exFAT support
    lm_sensors # system sensors
    pciutils # pci utils
  ];
}
