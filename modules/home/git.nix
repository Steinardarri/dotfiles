{
  lib,
  secrets,
  ...
}: {
  hydenix.hm.git.enable = true;

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
      # Secrets handled by git-crypt, from flake input
      url = {
        "https://oauth2:${secrets.github.oauth_token}@github.com" = {
          insteadOf = "https://github.com";
        };
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
