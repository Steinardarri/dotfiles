{
  pkgs,
  lib,
  ...
}: let
  myAliases = import ./aliases.nix;
  myFunctions = import ./functions.nix;
  myAbbreviations = import ./abbreviations.nix;
in {
  programs = {
    fish = {
      enable = true;

      interactiveShellInit = lib.mkBefore ''
        # Disable greeting
        set -g fish_greeting

        fastfetch

        # Color settings
        set fish_pager_color_prefix cyan
        set fish_color_autosuggestion brblack

        # Hard set atuni binding
        bind up _atuin_bind_up

        batman --export-env | source
      '';

      shellAliases = myAliases;
      functions = myFunctions;
      shellAbbrs = myAbbreviations;

      plugins = [
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
      settings = {
        dialect = "uk";
        auto_sync = false;
        update_check = false;
      };
    };
  };
}
