{
  config,
  ...
}: {
  xdg = {
    enable = true;

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
    # Hyprland and Wayland specific
    # XDG_SESSION_TYPE = "wayland";
    # XDG_CURRENT_DESKTOP = "Hyprland";
    # XDG_SESSION_DESKTOP = "Hyprland";

    # # Base XDG directories
    # XDG_CACHE_HOME = config.xdg.cacheHome;
    # XDG_CONFIG_HOME = config.xdg.configHome;
    # XDG_DATA_HOME = config.xdg.dataHome;
    # XDG_STATE_HOME = config.xdg.stateHome;
    # XDG_RUNTIME_DIR = "/run/user/$(id -u)";

    # # User directories
    # XDG_DOCUMENTS_DIR = config.xdg.userDirs.documents;
    # XDG_DOWNLOAD_DIR = config.xdg.userDirs.download;
    # XDG_MUSIC_DIR = config.xdg.userDirs.music;
    # XDG_PICTURES_DIR = config.xdg.userDirs.pictures;
    # XDG_PUBLICSHARE_DIR = config.xdg.userDirs.publicShare;
    # XDG_TEMPLATES_DIR = config.xdg.userDirs.templates;
    # XDG_VIDEOS_DIR = config.xdg.userDirs.videos;

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
