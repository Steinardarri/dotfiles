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
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/plain" = "org.xfce.mousepad.desktop";
        "text/x-shellscript" = "org.xfce.mousepad.desktop";
        "text/x-csrc" = "org.xfce.mousepad.desktop";
        "text/x-c++src" = "org.xfce.mousepad.desktop";
        "text/x-java" = "org.xfce.mousepad.desktop";
        "text/x-python" = "org.xfce.mousepad.desktop";
        "text/x-javascript" = "org.xfce.mousepad.desktop";
        "text/x-typescript" = "org.xfce.mousepad.desktop";
        "text/x-php" = "org.xfce.mousepad.desktop";
        "text/x-ruby" = "org.xfce.mousepad.desktop";
        "text/x-perl" = "org.xfce.mousepad.desktop";
        "text/x-go" = "org.xfce.mousepad.desktop";
        "text/x-rust" = "org.xfce.mousepad.desktop";
        "text/x-csharp" = "org.xfce.mousepad.desktop";
        "text/x-shader" = "org.xfce.mousepad.desktop";
        "text/x-markdown" = "org.xfce.mousepad.desktop";
        "text/x-tex" = "org.xfce.mousepad.desktop";
        "text/x-toml" = "org.xfce.mousepad.desktop";
        "text/x-yaml" = "org.xfce.mousepad.desktop";
        "text/x-json" = "org.xfce.mousepad.desktop";
        "text/xml" = "org.xfce.mousepad.desktop";
        "text/html" = "org.xfce.mousepad.desktop";
        "text/css" = "org.xfce.mousepad.desktop";
        "text/x-diff" = "org.xfce.mousepad.desktop";
        "text/x-patch" = "org.xfce.mousepad.desktop";
        "text/x-log" = "org.xfce.mousepad.desktop";
        "application/x-shellscript" = "org.xfce.mousepad.desktop";
        "application/json" = "org.xfce.mousepad.desktop";
        "application/xml" = "org.xfce.mousepad.desktop";
        "application/xhtml+xml" = "org.xfce.mousepad.desktop";
        "application/x-ruby" = "org.xfce.mousepad.desktop";
        "application/x-python" = "org.xfce.mousepad.desktop";
        "application/x-javascript" = "org.xfce.mousepad.desktop";
        "application/x-perl" = "org.xfce.mousepad.desktop";
        "application/x-php" = "org.xfce.mousepad.desktop";
        "application/x-tex" = "org.xfce.mousepad.desktop";
        "application/x-texinfo" = "org.xfce.mousepad.desktop";
        "application/x-troff" = "org.xfce.mousepad.desktop";
        "application/x-rpm" = "org.xfce.mousepad.desktop";
        "application/x-msdos-program" = "org.xfce.mousepad.desktop"; # Batch files
        "application/x-sharedlib" = "org.xfce.mousepad.desktop"; # Dynamic libraries (for viewing)
        "application/x-executable" = "org.xfce.mousepad.desktop"; # Binary executables (for viewing)
      };
    };

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
