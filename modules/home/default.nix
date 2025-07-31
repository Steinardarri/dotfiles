{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./gui
    ./hyprland
    ./services
    ./shell
    ./tui

    ./git.nix
    ./gtk.nix
    ./qt.nix
    ./xdg.nix
  ];

  # Let home-manager control itself
  programs.home-manager.enable = true;

  # Zsh used as the login shell, to launch hyprland and switch over to fish
  # https://nixos.wiki/wiki/Fish#Setting_fish_as_your_shell
  programs.zsh = {
    enable = true;
    profileExtra = ''
      if uwsm check may-start; then
        exec uwsm start hyprland-uwsm.desktop
      fi
    '';
    initContent = lib.mkBefore ''
      if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z $ZSH_EXECUTION_STRING ]]
      then
        if [[ -o login ]]; then LOGIN_OPTION='--login'; else LOGIN_OPTION=""; fi
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  home.stateVersion = "25.05";
}
