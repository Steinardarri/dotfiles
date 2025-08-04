{pkgs, ...}: {
  services = {
    desktopManager.gnome.extraGSettingsOverridePackages = with pkgs; [
      nemo
      gcr
      libcryptui
      nemo-seahorse
    ];
    gvfs.enable = true;
    udisks2.enable = true;
    upower.enable = true;
  };
}
