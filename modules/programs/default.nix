{
  pkgs,
  username,
  ...
}: {
  imports = [
    ./git.nix
    ./python.nix
  ];

  programs = {
    nh = {
      enable = true;
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep-since 14d --keep 15";
      };
      flake = "/home/${username}/dotfiles";
    };
  };

  home.packages = with pkgs; [
    # languages
    # gcc
    # nodejs
    # zig
    # # rust stuff
    # cargo-cache
    # cargo-expand
    # cargo-leptos
    # rustup
    # trunk
    # jq

    # dev stuf
    # cmake
    # gnumake
    # httpie
    # ninja
    # tree-sitter
    # valgrind
    # glib

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
    dust
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
    grc
    atuin
    starship
  ];

  home.sessionVariables = {
    PAGER = "bat";
  };
}
