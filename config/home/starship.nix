{ pkgs, ... }:

{
  # Starship Prompt
  programs.starship = {
    enable = true;
    package = pkgs.starship;
  };
}
