{
  pkgs,
  lib,
  ...
}: {
  hydenix.boot = {
    enable = true; # enable boot module
    useSystemdBoot = false; # disable for GRUB
    grubTheme = "Retroboot"; # or "Pochita"
    grubExtraConfig = ""; # additional GRUB configuration
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
  };

  # Overrides
  boot = {
    loader = {
      grub = {
        enable = lib.mkOptionDefault true;
        configurationLimit = 15;
        devices = ["nodev"];
      };
      timeout = lib.mkDefault 3;
    };
    plymouth.enable = true;
  };

  systemd.services.plymouth-quit-wait.enable = false;
}
