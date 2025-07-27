{
  pkgs,
  username,
  ...
}: {
  # Let home-manager control itself
  programs.home-manager.enable = true;
  home.username = username;
  home.homeDirectory = "/home/${username}";

  # Zsh used as the login shell, to launch hyprland and switch over to fish
  # https://nixos.wiki/wiki/Fish#Setting_fish_as_your_shell
  programs.zsh = {
    enable = true;
    profileExtra = ''
      if uwsm check may-start; then
        exec uwsm start hyprland-uwsm.desktop
      fi
    '';
    initExtraFirst = ''
      if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z $ZSH_EXECUTION_STRING ]]
      then
        if [[ -o login ]]; then LOGIN_OPTION='--login'; else LOGIN_OPTION=""; fi
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };

  ### Custom Modules From modules/home - to enable
  ###

  programs.git = {
    userName = "Steinar Darri Þorgilsson";
    userEmail = "steinar@steinardth.xyz";
  };

  home.sessionVariables = {
    EDITOR = "codium";
    VISUAL = "codium";
  };
}
