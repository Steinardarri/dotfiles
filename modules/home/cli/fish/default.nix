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

        # Color settings
        set fish_pager_color_prefix cyan
        set fish_color_autosuggestion brblack
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
    };

    # Companions
    starship.enable = true;
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

    direnv.enable = true; # Fish Integration Automatically Enabled
    direnv.nix-direnv.enable = true;

    atuin.enable = true;
    atuin.enableFishIntegration = true;
  };

  home.packages = with pkgs; [
    fishPlugins.colored-man-pages
  ];
}
