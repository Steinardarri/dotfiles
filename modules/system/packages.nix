{
  pkgs,
  ...
}: {
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
    kdePackages.qtdeclarative

    # formatters & linters
    alejandra # nix
    nixfmt
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
    btop
    clinfo
    coreutils
    curl
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
    p7zip

    # for fun
    cmatrix
    cowsay
    lolcat
    notcurses

    # ui & looks
    yad
    grc
    nix-output-monitor

    # hardware
    brightnessctl # screen brightness control
    udiskie # manage removable media
    ntfs3g # ntfs support
    exfat # exFAT support
    libinput-gestures # actions touchpad gestures using libinput
    libinput # libinput library
    lm_sensors # system sensors
    pciutils # pci utils
  ];
}
