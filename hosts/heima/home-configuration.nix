{username, ...}: {
  # Let home-manager control itself
  programs.home-manager.enable = true;
  home.username = username;
  home.homeDirectory = "/home/${username}";

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
