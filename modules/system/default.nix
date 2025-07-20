{pkgs, ...}: {
  imports = [
    ./boot
    ./driver
    ./services

    ./gaming.nix
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
    fish.enable = true;
    kdeconnect.enable = true;
    partition-manager.enable = true;
    nano = {
      enable = true;
      nanorc = ''
        syntax "Nanorc" "\.?nanorc$"
        comment "#"

        ## Possible errors and parameters
        icolor brightred "^[[:space:]]*((un)?set|include|syntax|i?color).*$"
        ## Colors
        icolor black " black"
        icolor red " red"
        icolor green " green"
        icolor yellow " yellow"
        icolor blue " blue"
        icolor magenta " magenta"
        icolor cyan " cyan"
        icolor white " white"
        icolor normal " normal"
        icolor brightblack " brightblack"
        icolor brightred " brightred"
        icolor brightgreen " brightgreen"
        icolor brightyellow " brightyellow"
        icolor brightblue " brightblue"
        icolor brightmagenta " brightmagenta"
        icolor brightcyan " brightcyan"
        icolor brightwhite " brightwhite"
        icolor brightnormal " brightnormal"
        icolor ,black ",black "
        icolor ,red ",red "
        icolor ,green ",green "
        icolor ,yellow ",yellow "
        icolor ,blue ",blue "
        icolor ,magenta ",magenta "
        icolor ,cyan ",cyan "
        icolor ,white ",white "
        icolor ,normal ",normal"
        icolor magenta "^[[:space:]]*i?color\>" "\<(start|end)="
        icolor yellow "^[[:space:]]*(set|unset)[[:space:]]+(errorcolor|functioncolor|keycolor|numbercolor|selectedcolor|statuscolor|stripecolor|titlecolor)[[:space:]]+(bright)?(white|black|red|blue|green|yellow|magenta|cyan|normal)?(,(white|black|red|blue|green|yellow|magenta|cyan|normal))?\>"

        ## Keywords
        icolor brightgreen "^[[:space:]]*(set|unset)[[:space:]]+(afterends|allow_insecure_backup|atblanks|autoindent|backup|backupdir|boldtext|brackets|breaklonglines|casesensitive|constantshow|cutfromcursor|emptyline|errorcolor|fill|functioncolor|guidestripe|historylog|jumpyscrolling|keycolor|linenumbers|locking|matchbrackets|morespace|mouse|multibuffer|noconvert|nohelp|nonewlines|nopauses|nowrap|numbercolor|operatingdir|positionlog|preserve|punct|quickblank|quotestr|rawsequences|rebinddelete|regexp|selectedcolor|showcursor|smarthome|smooth|softwrap|speller|statuscolor|stripecolor|suspend|tabsize|tabstospaces|tempfile|titlecolor|trimblanks|unix|view|whitespace|wordbounds|wordchars|zap)\>"
        icolor green "^[[:space:]]*(bind|set|unset|syntax|header|include|magic)\>"
        ## Strings
        icolor white ""(\\.|[^"])*""
        ## Comments
        icolor brightblue "^[[:space:]]*#.*$"
        icolor cyan "^[[:space:]]*##.*$"

        ## Trailing whitespace
        icolor ,green "[[:space:]]+$"

        set linenumbers
        set constantshow
        set tabstospaces
        set tabsize 2
        set zap
        set autoindent
        set indicator
      '';
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
