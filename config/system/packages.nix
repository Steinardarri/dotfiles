{pkgs, ...}: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List System Programs
  environment.systemPackages = with pkgs; [

    # core languages
    gcc
    nodejs
    python3
    zig
    # rust stuff
    cargo-cache
    cargo-expand
    cargo-leptos
    rustup
    trunk

    # dev stuf
    appimage-run
    gnumake
    httpie
    ninja

    # treesitter
    tree-sitter

    # language servers
    ccls # c / c++
    nil # nix
    nodePackages.pyright
    nodePackages.yaml-language-server
    pkgs.nodePackages.vscode-langservers-extracted # html, css, json, eslint

    # formatters & linters
    alejandra # nix
    black # python
    nodePackages.prettier
    ruff # python
    shellcheck
    shfmt
    sqlfluff
    tflint

    # system utils
    bat
    bottom
    btop
    coreutils
    curl
    du-dust
    eza
    fd
    findutils
    fx
    git
    helix
    htop
    jq
    lm_sensors
    lsd
    lshw
    mosh
    nh
    nix-output-monitor
    nvd
    parallel
    pkg-config
    procs
    ripgrep
    sd
    tmux
    toybox
    tree
    unrar
    unzip
    wget
    wormhole-william
    zip

    # for fun
    cmatrix
    cowsay
    lolcat
    notcurses

    # ui & looks
    fastfetch
    symbola
    yad
  ];

  programs = {
    dconf.enable = true;
    mtr.enable = true;
  };
}
