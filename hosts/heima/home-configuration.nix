{username, ...}: {
  home.username = username;
  home.homeDirectory = "/home/${username}";

  ### Custom Modules From modules/home - to enable
  _torrent.enable = true;
  ###

  programs.git = {
    userName = "Steinar Darri Þorgilsson";
    userEmail = "steinar@steinardth.xyz";
  };

  home.sessionVariables = {
    EDITOR = "nano";
    VISUAL = "codium";
  };
}
