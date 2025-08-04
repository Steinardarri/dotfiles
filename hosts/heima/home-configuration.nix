{username, ...}: {
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
    sessionVariables = {
      EDITOR = "nano";
      VISUAL = "codium";
    };
  };

  ### Custom Modules From modules/home - to enable
  _torrent.enable = true;
  ###

  programs.git = {
    userName = "Steinar Darri Þorgilsson";
    userEmail = "steinar@steinardth.xyz";
  };
}
