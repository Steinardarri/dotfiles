{
  pkgs,
  config,
  inputs,
  ...
}: {
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List System Programs
  environment.systemPackages = with pkgs; [

    # key tools
    gh # for bootstrapping
    just

    # core languages
    gcc
    go
    lua
    nodejs
    python3
    typescript
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
    libvirt
    meson
    mkcert
    ninja
    socat
    virt-viewer

    # treesitter
    tree-sitter

    # language servers
    ccls # c / c++
    gopls
    nil # nix
    nodePackages.pyright
    nodePackages.typescript-language-server
    nodePackages.yaml-language-server
    pkgs.nodePackages.vscode-langservers-extracted # html, css, json, eslint
    sumneko-lua-language-server

    # formatters & linters
    alejandra # nix
    black # python
    deadnix # nix
    golangci-lint
    nodePackages.prettier
    ruff # python
    shellcheck
    shfmt
    sqlfluff
    statix # nix
    tflint

    # system utils
    bat
    bottom
    brightnessctl
    btop
    coreutils
    curl
    du-dust
    eza
    fd
    findutils
    fx
    git
    git-crypt
    helix
    htop
    jq
    killall
    libnotify
    lm_sensors
    lsd
    lshw
    mosh
    networkmanagerapplet
    nh
    nix-output-monitor
    nvd
    parallel
    pkg-config
    polkit_gnome
    procs
    ripgrep
    sd
    tmux
    toybox
    tree
    unrar
    unzip
    wget
    wl-clipboard
    wormhole-william
    zip

    # for fun
    cmatrix
    cowsay
    lolcat

    # ui & looks
    hyprcursor
    material-icons
    neofetch
    notcurses
    noto-fonts-color-emoji
    playerctl
    swappy
    symbola
    yad
  ];

  programs = {
    dconf.enable = true;
    seahorse.enable = true;
    hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      xwayland.enable = true;
    };
    fuse.userAllowOther = true;
    mtr.enable = true;
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    virt-manager.enable = true;
  };

  virtualisation.libvirtd.enable = true;
}
