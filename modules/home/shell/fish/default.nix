{
  pkgs,
  lib,
  config,
  ...
}: let
  cfg = config.hydenix.hm.shell;
  myAliases = import ./aliases.nix;
  myFunctions = import ./functions.nix;
in {
  # Hydenix fish additions / overrides
  config = lib.mkIf cfg.fish.enable {
    programs = {
      fish = {
        enable = true;

        shellAliases = myAliases;
        functions = myFunctions;

        shellInit = ''
          # Disable fish greeting
          set -g fish_greeting
        '';

        interactiveShellInit = lib.mkAfter ''
          starship init fish | source
          atuin init fish | source
          zoxide init fish --cmd cd | source
        '';
      };

      # Companions
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
      # direnv.enableFishIntegration = true; Automatically enabled
      direnv.nix-direnv.enable = true;

      atuin.enable = true;
      atuin.enableFishIntegration = true;

      starship.enableFishIntegration = true;
    };

    home.packages = with pkgs; [
      fishPlugins.colored-man-pages
    ];
  };
}
