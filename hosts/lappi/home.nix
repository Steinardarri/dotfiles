{ config, pkgs, lib, username, ... }: {
  
  home.stateVersion = "23.11";

  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";

    sessionVariables = {
      SHELL = "/etc/profiles/per-user/${username}/bin/zsh";
      FLAKE = "/home/${username}/NixOS_Config";
      EDITOR = "hx";
      VISUAL = "vscodium";
    };
  };

}
