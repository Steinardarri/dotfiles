{lib, ...}: {
  imports = [
    ./gui
    ./shell
  ];

  hydenix.hm = {
    enable = true;
    comma.enable = true; # useful nix tool to run software without installing it first
    dolphin.enable = true;
    fastfetch.enable = true;
    firefox.enable = true;
    git = {
      enable = true;
      name = "Steinar Darri Þorgilsson";
      email = "steinar@steinardth.xyz";
    };
    hyde.enable = true; # enable hyde module
    hyprland = {
      enable = true; # enable hyprland module
      extraConfig = ""; # extra hyprland config text
    };
    lockscreen = {
      enable = true;
      hyprlock = true;
      swaylock = false;
    };
    notifications.enable = true;
    qt.enable = true;
    rofi.enable = true;
    screenshots = {
      enable = true;
      grim.enable = true; # enable grim screenshot tool
      slurp.enable = true; # enable slurp region selection tool
      satty.enable = false;
      swappy.enable = true; # enable swappy screenshot editor
    };
    social = {
      enable = true;
      discord.enable = false;
      webcord.enable = false;
      vesktop.enable = true;
    };
    spotify.enable = true;
    swww.enable = true;
    terminals = {
      enable = true;
      kitty = {
        enable = true;
        configText = "";
      };
    };
    theme = {
      enable = true;
      active = "Catppuccin Mocha";
      themes = [
        "Catppuccin Mocha"
        "Catppuccin Latte"
      ]; # default enabled themes, full list in https://github.com/richen604/hydenix/tree/main/hydenix/sources/themes
    };
    waybar = {
      enable = true;
      userStyle = "";
    };
    wlogout.enable = true;
    xdg.enable = true;
  };

  # Custom Git Settings
  programs.git = {
    enable = true;
    delta = {
      enable = true;
      options = {
        line-numbers = true;
        side-by-side = true;
        navigate = true;
      };
    };
    extraConfig = {
      init.defaultBranch = lib.mkForce "master";
      color.ui = "Auto";
      core = {
        filemode = false;
        bare = false;
        logallrefupdates = true;
        # Don't consider trailing space change as a cause for merge conflicts
        whitespace = "-trailing-space";
        protectNTFS = true;
        bigFileThreshold = "100m";
      };
      pull.rebase = false;
      push = {
        default = "simple";
        autoSetupRemote = true;
      };
      merge = {
        conflictstyle = "diff3";
      };
      diff = {
        # Show renames/moves as such
        renames = true;
        colorMoved = "default";
        # Use better, descriptive initials (c, i, w) instead of a/b.
        mnemonicPrefix = true;
      };
      fetch.prune = true;
      status.submoduleSummary = true;
    };
    aliases = {
      # List available aliases
      aliases = "!git config --get-regexp alias | sed -re 's/alias\\.(\\S*)\\s(.*)$/\\1 = \\2/g'";
      # Display tree-like log, because default log is a pain…
      lg = "log --graph --date=relative --pretty=tformat:'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%an %ad)%Creset'";
      # Ammend last commit, either changes or just message
      ammend = "commit --amend";
      # Undo last commit but keep changed files in stage
      uncommit = "reset --soft HEAD~1";
      # See recent changes
      last = "log -1 HEAD";
      diffLast = "diff HEAD^ HEAD";
      diffDev = "diff development..HEAD";
      # Branch management
      rebDev = "!git pull --all && git rebase --interactive development";
      coDev = "checkout development";
      coFea = "checkout feature";

      # Extra
      pf = "push --force-with-lease"; # safer than --force
      wip = "!git add -A && git commit -m 'WIP'"; # quick checkpoint
      s = "status --short --branch";
      sw = "switch"; # modern checkout replacement
    };
    # signing = {
    #   format = "ssh";
    #   signByDefault = true;
    # };
  };
}
