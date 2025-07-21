{
  lib,
  config,
  ...
}: {
  options = {
    _laptop.enable = lib.mkEnableOption "User-Defined Laptop Module";
  };

  config = lib.mkIf config._laptop.enable {
    powerManagement.enable = true;
    powerManagement.powertop.enable = true;
    services.thermald.enable = true;

    services.auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };
  };
}
