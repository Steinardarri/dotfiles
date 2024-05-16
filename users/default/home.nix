{
  config,
  pkgs,
  inputs,
  username,
  host,
  gtkThemeFromScheme,
  ...
}: let
  inherit
    (import ./../../hosts/${host}/options.nix)
    gitUsername
    gitEmail
    theme
    browser
    wallpaperDir
    wallpaperGit
    flakeDir
    waybarStyle
    ;
in {
  # Home Manager Settings
  home.username = "${username}";
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "23.11";

  # Set The Colorscheme
  colorScheme = inputs.nix-colors.colorSchemes."${theme}";

  # Import Program Configurations
  imports = [
    inputs.nix-colors.homeManagerModules.default
    inputs.nixvim.homeManagerModules.nixvim
    inputs.hyprland.homeManagerModules.default
    ./../../config/home
  ];

  # Define Settings For Xresources
  xresources.properties = {
    "Xcursor.size" = 24;
  };

  # Install & Configure Git
  programs.git = {
    enable = true;
    userName = "${gitUsername}";
    userEmail = "${gitEmail}";
    package = pkgs.git;
    delta.enable = true;
    delta.options = {
      line-numbers = true;
      side-by-side = true;
      navigate = true;
    };
    extraConfig = {
      color = {
        ui = "Auto";
      };
      core = {
        filemode = true;
        bare = false;
        logallrefupdates = true;
        # Don't consider trailing space change as a cause for merge conflicts
        whitespace = "-trailing-space";
      };
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
      fetch = {
        prune = true;
      };
      status = {
        submoduleSummary = true;
      };
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
    };
  };

  # Create XDG Dirs
  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };

  dconf.settings = {
    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };

  programs.home-manager.enable = true;
}
