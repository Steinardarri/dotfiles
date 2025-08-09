{
  config,
  pkgs,
  inputs,
  ...
}: {
  xdg = {
    enable = true;

    portal = let
      hypr-pkgs = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
    in {
      enable = true;
      extraPortals = [
        hypr-pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal
      ];
      xdgOpenUsePortal = true;
      configPackages = [
        hypr-pkgs.xdg-desktop-portal-hyprland
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal
      ];
    };

    mime.enable = true;
    mimeApps.enable = true;

    userDirs = {
      enable = true;
      createDirectories = true;

      # Define standard XDG user directories
      documents = "${config.home.homeDirectory}/Documents";
      download = "${config.home.homeDirectory}/Downloads";
      music = "${config.home.homeDirectory}/Music";
      pictures = "${config.home.homeDirectory}/Pictures";
      publicShare = "${config.home.homeDirectory}/Public";
      templates = "${config.home.homeDirectory}/Templates";
      videos = "${config.home.homeDirectory}/Videos";
    };

    # Define standard XDG base directories
    cacheHome = "${config.home.homeDirectory}/.cache";
    configHome = "${config.home.homeDirectory}/.config";
    dataHome = "${config.home.homeDirectory}/.local/share";
    stateHome = "${config.home.homeDirectory}/.local/state";
  };

  # Set environment variables
  home.sessionVariables = {
    # Additional XDG-related variables
    LESSHISTFILE = "/tmp/less-hist";
    PARALLEL_HOME = "${config.xdg.configHome}/parallel";
    SCREENRC = "${config.xdg.configHome}/screen/screenrc";

    # History configuration // explicit to not nuke history
    HISTSIZE = "10000";
    SAVEHIST = "10000";
    setopt_EXTENDED_HISTORY = "true";
    setopt_INC_APPEND_HISTORY = "true";
    setopt_SHARE_HISTORY = "true";
    setopt_HIST_EXPIRE_DUPS_FIRST = "true";
    setopt_HIST_IGNORE_DUPS = "true";
    setopt_HIST_IGNORE_ALL_DUPS = "true";
  };
}
