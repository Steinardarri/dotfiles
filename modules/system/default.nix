{pkgs, ...}: {
  imports = [
    ./boot
    ./desktop
    ./driver
    ./hardware
    ./kernel
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
    kdePackages.partitionmanager
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

  fonts = {
    packages = with pkgs; [
      dejavu_fonts
      nerd-fonts.hack
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
    kdeconnect.enable = true;
    partition-manager.enable = true;
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
