{pkgs, ...}: {
  imports = [
    ./boot
    ./desktop
    ./driver
    ./hardware
    ./kernel

    ./distrobox.nix
    ./flatpak.nix
    ./gaming.nix
    ./python.nix
    ./syncthing.nix
  ];

  # List System Programs
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
    gnumake
    httpie
    ninja

    # treesitter
    tree-sitter

    # language servers
    ccls # c / c++
    nixd # nix
    nodePackages.pyright
    nodePackages.yaml-language-server
    pkgs.nodePackages.vscode-langservers-extracted # html, css, json, eslint

    # formatters & linters
    alejandra # nix
    nodePackages.prettier
    shellcheck
    shfmt
    sqlfluff
    tflint

    # media
    imagemagick
    yt-dlg
    ffmpeg
    inkscape

    # system utils
    aha
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
    git
    glxinfo
    helix
    htop
    jq
    lm_sensors
    lsd
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

  fonts = {
    packages = with pkgs; [
      dejavu_fonts
      (nerdfonts.override {fonts = ["Hack" "FiraCode"];})
    ];
    fontDir.enable = true;
  };

  programs = {
    dconf.enable = true;
    mtr.enable = true;
    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
  };

  # Regist appimage-run as the executor of appimages
  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };
}
