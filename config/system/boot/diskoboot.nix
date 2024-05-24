{
  hostname,
  lib,
  ...
}: let
  inherit (import ../../../hosts/${hostname}/options.nix) boot;
in
  lib.mkIf ("${boot}" == "disko") {
    boot = {
      loader = {
        grub = {
          enable = true;
          efiSupport = true;
          efiInstallAsRemovable = true;
          configurationLimit = 15;
        };
        timeout = 3;
      };
    };
  }
