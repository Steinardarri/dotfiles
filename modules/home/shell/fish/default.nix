{
  pkgs,
  lib,
  hostname,
  ...
}: let
  inherit
    (import ../../../../hosts/${hostname}/options.nix)
    theShell
    ;
in
  lib.mkIf (theShell == "fish") {
    programs = {
      fish = {
        enable = true;
        # useBabelfish = true;

        shellAliases = import ./aliases.nix;

        functions = import ./functions.nix {inherit pkgs lib;};

        shellInit = ''
          # Disable fish greeting
          set -g fish_greeting

          # Set fish colors
          set -g fish_color_command blue
          set -g fish_color_param cyan
          set -g fish_color_redirection yellow
          set -g fish_color_comment brblack
          set -g fish_color_error red
          set -g fish_color_escape magenta
          set -g fish_color_operator green
          set -g fish_color_quote yellow
          set -g fish_color_autosuggestion brblack
          set -g fish_color_valid_path --underline

          # Enable vi mode
          # fish_vi_key_bindings
        '';

        interactiveShellInit = ''
          starship init fish | source

          # Set up fzf key bindings if fzf is available
          if command -v fzf >/dev/null
            fzf_key_bindings
          end
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
      direnv.enableFishIntegration = true;
      direnv.nix-direnv.enable = true;

      atuin.enable = true;
      atuin.enableFishIntegration = true;
    };

    home.packages = with pkgs; [
      fishPlugins.colored-man-pages
    ];
  }
