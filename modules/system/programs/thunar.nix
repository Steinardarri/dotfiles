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
    gvfs.enable = true; # Mount, trash, and other functionalities
    tumbler.enable = true; # Thumbnail support for images
    udisks2.enable = true; # Storage
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
