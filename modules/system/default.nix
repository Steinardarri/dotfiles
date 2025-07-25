{
  pkgs,
  lib,
  username,
  ...
}: {
  imports = [
    ./boot
    ./drivers
    ./gui
    ./services

    ./gaming.nix
    ./locale.nix
    ./packages.nix
  ];

  hydenix = {
    audio.enable = true;
    # Imported gaming module overrides it, when enabled
    gaming.enable = false;
    hardware.enable = true;
    network.enable = true;
    sddm = {
      enable = true;
      theme = "Candy"; # Candy, Corners
    };
    system.enable = true;
  };


  time.timeZone = "Atlantic/Reykjavik";

  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      warn-dirty = false;
      download-buffer-size = 524288000;
      max-jobs = 4;
      cores = 4;
      show-trace = false;
    };
    substituters = [
      "https://install.determinate.systems"
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
  nixpkgs.config.allowUnfree = true;

  programs = {
    nh = {
      enable = true;
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep-since 14d --keep 10";
      };
      flake = "/home/${username}/dotfiles";
    };
    fish.enable = true;
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

  environment.variables = {
    FLAKE = "/home/${username}/dotfiles";
    SHELL = "/etc/profiles/per-user/${username}/bin/fish";
    NIXOS_OZONE_WL = "1";
  };

  fonts = {
    packages = with pkgs; [
      nerd-fonts.hack
    ];
    fontDir.enable = true;
  };

  # Catppuccin Mocha Color Scheme For TTY Console
  console = {
    colors = [
      # 0-7 normal
      "11111b"
      "f38ba8"
      "a6e3a1"
      "f9e2af"
      "89b4fa"
      "f5c2e7"
      "94e2d5"
      "a6adc8"
      # 8-15 bright
      "6c7086"
      "eba0ac"
      "a6e3a1"
      "fab387"
      "74c7ec"
      "cba6f7"
      "89dceb"
      "cdd6f4"
    ];
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

  system.stateVersion = "25.05";
}
