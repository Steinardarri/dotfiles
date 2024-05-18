{
  pkgs,
  config,
  ...
}: let
  inherit (import ../../hosts/${host}/options.nix) boot;
in
  lib.mkIf ("${boot}" == "gpt") {
    boot = {
      loader = {
        efi = {
          efiSysMountPoint = "/boot";
          canTouchEfiVariables = true; # XOR
        };
        grub = {
          enable = true;
          devices = ["nodev"];
          # efiInstallAsRemovable = true; # XOR
          efiSupport = true;
          useOSProber = true;
          configurationLimit = 15;
        };
        timeout = 3;
      };
    };
  }
  lib.mkIf ("${boot}" == "noefi") {
    boot = {
      loader = {
        grub = {
          enable = true;
          devices = ["nodev"];
          useOSProber = true;
          configurationLimit = 15;
        };
        timeout = 3;
      };
    };
  }
