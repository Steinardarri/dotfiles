{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
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
    ccls # c / c++
    nixd # nix
    nodePackages.yaml-language-server
    nodePackages.vscode-langservers-extracted # html, css, json, eslint

    # formatters & linters
    alejandra # nix
    nodePackages.prettier
    shellcheck
    shfmt

    # media
    imagemagick
    yt-dlg
    ffmpeg
    inkscape

    # system utils
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
    htop
    lm_sensors
    lshw
    mosh
    nix-output-monitor
    nvd
    parallel
    pinentry-all
    pkg-config
    procs
    ripgrep
    sd
    tmux
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
    fastfetch
    yad
  ];
}
