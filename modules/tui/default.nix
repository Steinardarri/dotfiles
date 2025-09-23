{pkgs, ...}: {
  imports = [
    ./yazi

    ./helix.nix
    ./nano.nix
    ./zellij.nix
  ];

  home.packages = with pkgs; [
    # languages
    gcc
    nodejs
    zig
    # rust stuff
    cargo-cache
    cargo-expand
    cargo-leptos
    rustup
    trunk
    jq

    # dev stuf
    cmake
    gnumake
    httpie
    ninja
    tree-sitter
    valgrind

    # language servers / debuggers
    nixd # nix

    # formatters & linters
    alejandra # nix formatter
    nixfmt # nix formatter
    statix # nix linter
    nodePackages.prettier
    shellcheck
    shfmt
    ruff # python

    # utils
    bat
    bat-extras.batman
    bottom
    broot
    btop
    curl
    deadnix
    du-dust
    eza
    fd
    fzf
    helix
    lshw
    lsof
    manix
    mosh
    nvd
    p7zip
    parallel
    pkg-config
    procs
    ripgrep
    sd
    tldr
    tree
    wget
    yazi
    zoxide

    # for fun
    cmatrix
    cowsay
    lolcat
    notcurses
    fastfetch

    # ui & looks
    nh
    grc
    nix-output-monitor
    atuin
    starship
  ];

  home.sessionVariables = {
    PAGER = "bat";
  };
}
