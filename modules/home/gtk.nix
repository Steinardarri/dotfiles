{pkgs, ...}: {
  home.packages = with pkgs; [
    gtk3
    gtk4
    glib
    gsettings-desktop-schemas
    gnome-settings-daemon
    gnome-tweaks
    gnomeExtensions.window-gestures
    nwg-look
    emote
  ];

  home.file = {
    ".config/nwg-look/config" = {
      text = ''
        {
         "export-settings-ini": true,
         "export-gtkrc-20": true,
         "export-index-theme": true,
         "export-xsettingsd": true
        }
      '';
    };
  };

  home.sessionVariables = {
    GDK_BACKEND = "wayland,x11,*"; # Use wayland if available. If not: try x11, then any other GDK backend.
    GDK_SCALE = "1"; # Set GDK scale to 1 // For Xwayland on HiDPI
  };
}
