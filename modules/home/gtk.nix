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
}
