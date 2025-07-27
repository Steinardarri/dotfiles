{
  pkgs,
  inputs,
  ...
}: let
  myAliases = import ./aliases.nix;
  myFunctions = import ./functions.nix;
in {
  imports = [
    inputs.nix-index-database.homeModules.nix-index
  ];

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

    direnv.enable = true;
    # Fish Integration Automatically Enabled
    direnv.nix-direnv.enable = true;

    atuin.enable = true;
    atuin.enableFishIntegration = true;
  };

  home.packages = with pkgs; [
    fishPlugins.colored-man-pages
    fishPlugins.done
    fishPlugins.forgit
    fishPlugins.grc
  ];
}
