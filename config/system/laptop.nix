{
  pkgs,
  config,
  lib,
  hostname,
  ...
}: let
  inherit (import ../../hosts/${hostname}/options.nix) laptop;
in
  lib.mkIf (laptop == true) {
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
  }
