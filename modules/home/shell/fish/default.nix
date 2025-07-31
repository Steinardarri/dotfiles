{pkgs, ...}: let
  myAliases = import ./aliases.nix;
  myFunctions = import ./functions.nix;
in {
  programs = {
    fish = {
      enable = true;

      interactiveShellInit = ''
        # Disable greeting
        set -g fish_greeting

        fastfetch
      '';

      shellAliases = myAliases;
      functions = myFunctions;
      shellAbbrs = {
        ".." = "cd ..";
        "..." = "cd ../..";
        ".3" = "cd ../../..";
        ".4" = "cd ../../../..";
        ".5" = "cd ../../../../..";
        mkdir = "mkdir -p";
      };

      plugins = [
        {
          name = "colored-man-pages";
          src = pkgs.fishPlugins.colored-man-pages.src;
        }
        {
          name = "grc";
          src = pkgs.fishPlugins.grc.src;
        }
        {
          name = "done";
          src = pkgs.fishPlugins.done.src;
        }
        {
          name = "forgit";
          src = pkgs.fishPlugins.forgit.src;
        }
      ];
    };

    # Companions
    starship.enableFishIntegration = true;

    nix-index.enable = true;
    nix-index.enableFishIntegration = true;
    nix-index-database.comma.enable = true;

    fzf.enable = true;
    fzf.enableFishIntegration = true;

    zoxide.enable = true;
    zoxide.enableFishIntegration = true;

    broot.enable = true;
    broot.enableFishIntegration = true;

    direnv.enable = true;
    # Fish Integration Automatically Enabled
    direnv.nix-direnv.enable = true;

    atuin.enable = true;
    atuin.enableFishIntegration = true;
  };
}
