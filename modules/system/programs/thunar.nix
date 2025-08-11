{pkgs, ...}: {
  programs = {
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-media-tags-plugin
        thunar-vcs-plugin
        thunar-volman
      ];
    };
    xfconf.enable = true;
    file-roller.enable = true;
  };

  services = {
    tumbler.enable = true; # Thumbnail support for images
  };

  systemd.user.services.thunar-daemon = {
    description = "Thunar Daemon";
    enable = true;
    wantedBy = ["graphical-session.target"];
    after = ["graphical-session.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = "thunar --daemon";
    };
  };

  # Extra thumbnailer support
  environment.systemPackages = with pkgs; [
    webp-pixbuf-loader
    freetype
    ffmpegthumbnailer
    totem
    poppler
    libgsf
    f3d
  ];
}
