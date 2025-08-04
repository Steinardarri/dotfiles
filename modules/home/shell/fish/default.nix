{pkgs, ...}: let
  myAliases = import ./aliases.nix;
  myFunctions = import ./functions.nix;
  myAbbreviations = import ./abbreviations.nix;
in {
  programs = {
    fish = {
      enable = true;

      interactiveShellInit = ''
        # Disable greeting
        set -g fish_greeting

        fastfetch

        # Color settings
        set fish_pager_color_prefix cyan
        set fish_color_autosuggestion brblack
      '';

      shellAliases = myAliases;
      functions = myFunctions;
      shellAbbrs = myAbbreviations;

      plugins = [
        {
          name = "colored-man-pages";
          inherit (pkgs.fishPlugins.colored-man-pages) src;
        }
        {
          name = "grc";
          inherit (pkgs.fishPlugins.grc) src;
        }
        {
          name = "done";
          inherit (pkgs.fishPlugins.done) src;
        }
        {
          name = "forgit";
          inherit (pkgs.fishPlugins.forgit) src;
        }
      ];
    };

    # Companions
    starship.enableFishIntegration = true;

    nix-index = {
      enable = true;
      enableFishIntegration = true;
    };
    nix-index-database.comma.enable = true;

    fzf = {
      enable = true;
      enableFishIntegration = true;
    };

    zoxide = {
      enable = true;
      enableFishIntegration = true;
      options = ["--cmd cd"];
    };

    broot = {
      enable = true;
      enableFishIntegration = true;
    };

    # Fish Integration Automatically Enabled
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };

    atuin = {
      enable = true;
      enableFishIntegration = true;
    };
  };
}
