{ config, pkgs, ... }:

{
  programs.helix = {
    enable = true;

    settings = {
      theme = "nord";
      editor = {
        true-color = true;
        shell = [ "zsh" "-c" ];
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
    };
  };
}