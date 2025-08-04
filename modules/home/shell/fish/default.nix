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

    nix-index.enable = true;
    nix-index.enableFishIntegration = true;
    nix-index-database.comma.enable = true;

    fzf.enable = true;
    fzf.enableFishIntegration = true;

    zoxide.enable = true;
    zoxide.enableFishIntegration = true;
    zoxide.options = ["--cmd cd"];

    broot.enable = true;
    broot.enableFishIntegration = true;

    direnv.enable = true;
    # Fish Integration Automatically Enabled
    direnv.nix-direnv.enable = true;

    atuin.enable = true;
    atuin.enableFishIntegration = true;
  };
}
