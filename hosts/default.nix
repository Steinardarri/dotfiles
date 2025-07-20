{
  pkgs,
  lib,
  ...
}: {
  hydenix = {
    enable = true;

    timezone = "Atlantic/Reykjavik";
    locale = "en_GB.UTF-8";

    audio.enable = true; # enable audio module
    boot = {
      enable = true; # enable boot module
      useSystemdBoot = false; # disable for GRUB
      grubTheme = "Retroboot"; # or "Pochita"
      grubExtraConfig = ""; # additional GRUB configuration
      kernelPackages = pkgs.linuxPackages_xanmod_latest;
    };
    hardware.enable = true;
    network.enable = true;
    nix.enable = true;
    sddm.enable = false;
    system.enable = true;
  };

  nix = {
    settings = {
      warn-dirty = false;
      download-buffer-size = 524288000;
      max-jobs = 4;
      cores = 4;
      show-trace = false;
    };
  };

  programs = {
    nh = {
      enable = true;
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep-since 14d --keep 15";
      };
    };
  };

  # Hydenix Overrides

  programs = {
    hyprland = {
      withUWSM = lib.mkForce true;
    };
    zsh.enable = lib.mkForce false;
  };

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "is_IS.UTF-8";
    LC_IDENTIFICATION = "is_IS.UTF-8";
    LC_MEASUREMENT = "is_IS.UTF-8";
    LC_MONETARY = "is_IS.UTF-8";
    LC_NAME = "is_IS.UTF-8";
    LC_NUMERIC = "is_IS.UTF-8";
    LC_PAPER = "is_IS.UTF-8";
    LC_TELEPHONE = "is_IS.UTF-8";
    LC_TIME = "is_IS.UTF-8";
  };
  console.keyMap = "is-latin1";
}
