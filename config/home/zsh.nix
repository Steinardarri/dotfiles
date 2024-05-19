{
  config,
  lib,
  pkgs,
  hostname,
  ...
}: let
  inherit (import ../../hosts/${hostname}/options.nix) theShell;
in
  lib.mkIf (theShell == "zsh") {
    programs = {
      zsh = {
        enable = true;
        autocd = true;
        enableAutosuggestions = true;
        enableCompletion = true;
        history.size = 10000;
        history.save = 10000;
        history.expireDuplicatesFirst = true;
        history.ignoreDups = true;
        history.ignoreSpace = true;
        historySubstringSearch.enable = true;

        plugins = [
          {
            name = "fast-syntax-highlighting";
            src = "${pkgs.zsh-fast-syntax-highlighting}/share/zsh/site-functions";
          }
          {
            name = "zsh-nix-shell";
            file = "nix-shell.plugin.zsh";
            src = pkgs.fetchFromGitHub {
              owner = "chisui";
              repo = "zsh-nix-shell";
              rev = "v0.5.0";
              sha256 = "0za4aiwwrlawnia4f29msk822rj9bgcygw6a8a6iikiwzjjz0g91";
            };
          }
        ];

        shellAliases = {
          "..." = "./..";
          "...." = "././..";
          cd = "z";
          gc = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
          refresh = "source ${config.home.homeDirectory}/.zshrc-personal";
          show_path = "echo $PATH | tr ':' '\n'";
          hg = "history 0 | grep";
          shx = "sudo hx";
          flake-rebuild = "nh os switch --hostname ${hostname}";
          flake-update = "nh os switch --hostname ${hostname} --update";

          # add more git aliases here if you want them
          gapa = "git add --patch";
          grpa = "git reset --patch";
          gst = "git status";
          gdh = "git diff HEAD";
          gp = "git push";
          gph = "git push -u origin HEAD";
          gco = "git checkout";
          gcob = "git checkout -b";
          gcm = "git checkout master";
          gcd = "git checkout develop";

          ls = "ncls";
          ll = "ncls -l";
          la = "ncls -a";
          lal = "ncls -al";
        };

        envExtra = ''
          export PATH=$PATH:$HOME/.local/bin
        '';

        profileExtra = ''
          #if [ -z "$DISPLAY" ] && [ "$XDG_VNTR" = 1 ]; then
          #  exec Hyprland
          #fi
        '';

        initExtraFirst = ''
          HISTFILE=~/.histfile
          setopt autocd nomatch
          unsetopt beep extendedglob notify
          autoload -Uz compinit
          compinit
        '';

        initExtra = ''
          ncneofetch

          bindkey '^[[3~' delete-char                     # Key Del
          bindkey '^[[5~' beginning-of-buffer-or-history  # Key Page Up
          bindkey '^[[6~' end-of-buffer-or-history        # Key Page Down
          bindkey '^[[1;3D' backward-word                 # Key Alt + Left
          bindkey '^[[1;3C' forward-word                  # Key Alt + Right
          bindkey '^[[H' beginning-of-line                # Key Home
          bindkey '^[[F' end-of-line                      # Key End

          if type nproc &>/dev/null; then
            export MAKEFLAGS="$MAKEFLAGS -j$(($(nproc)-1))"
          fi

          zstyle ':completion:*:*:*:*:*' menu select

          # Complete . and .. special directories
          zstyle ':completion:*' special-dirs true

          zstyle ':completion:*' list-colors ""
          zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

          # disable named-directories autocompletion
          zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

          # Use caching so that commands like apt and dpkg complete are useable
          zstyle ':completion:*' use-cache on
          zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"

          # Don't complete uninteresting users
          zstyle ':completion:*:*:*:users' ignored-patterns \
                  adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
                  clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
                  gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
                  ldap lp mail mailman mailnull man messagebus  mldonkey mysql nagios \
                  named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
                  operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
                  rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
                  usbmux uucp vcsa wwwrun xfs '_*'
          # ... unless we really want to.
          zstyle '*' single-ignored complete

          # https://thevaluable.dev/zsh-completion-guide-examples/
          zstyle ':completion:*' completer _extensions _complete _approximate
          zstyle ':completion:*:descriptions' format '%F{green}-- %d --%f'
          zstyle ':completion:*' group-name ""
          zstyle ':completion:*:*:-command-:*:*' group-order alias builtins functions commands
          zstyle ':completion:*' squeeze-slashes true
          zstyle ':completion:*' matcher-list "" 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

          # mkcd is equivalent to takedir
          function mkcd takedir() {
            mkdir -p $@ && cd ''${@:$#}
          }

          function takeurl() {
            local data thedir
            data="$(mktemp)"
            curl -L "$1" > "$data"
            tar xf "$data"
            thedir="$(tar tf "$data" | head -n 1)"
            rm "$data"
            cd "$thedir"
          }

          function takegit() {
            git clone "$1"
            cd "$(basename ''${1%%.git})"
          }

          function take() {
            if [[ $1 =~ ^(https?|ftp).*\.(tar\.(gz|bz2|xz)|tgz)$ ]]; then
              takeurl "$1"
            elif [[ $1 =~ ^([A-Za-z0-9]\+@|https?|git|ssh|ftps?|rsync).*\.git/?$ ]]; then
              takegit "$1"
            else
              takedir "$@"
            fi
          }

          WORDCHARS='*?[]~=&;!#$%^(){}<>'

          # fixes duplication of commands when using tab-completion
          export LANG=C.UTF-8

          eval "$(starship init zsh)"
        '';
      };

      # zsh companions
      nix-index.enable = true;
      nix-index.enableZshIntegration = true;
      nix-index-database.comma.enable = true;

      fzf.enable = true;
      fzf.enableZshIntegration = true;

      zoxide.enable = true;
      zoxide.enableZshIntegration = true;

      broot.enable = true;
      broot.enableZshIntegration = true;

      direnv.enable = true;
      direnv.enableZshIntegration = true;
      direnv.nix-direnv.enable = true;
    };
  }
