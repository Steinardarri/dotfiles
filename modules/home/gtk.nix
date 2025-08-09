{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      gtk3
      gtk4
      glib
      gsettings-desktop-schemas
      gnome-settings-daemon
      gnome-tweaks
      gnomeExtensions.window-gestures
      nwg-look
      emote
      adwaita-icon-theme
    ];

    file = {
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

    sessionVariables = {
      GDK_BACKEND = "wayland"; # Use wayland if available
      GDK_SCALE = "1"; # Set GDK scale to 1 // For Xwayland on HiDPI
      # GTK_USE_PORTAL = "1";
    };
  };
}
