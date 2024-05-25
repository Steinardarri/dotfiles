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
          efiSupport = true;
          efiInstallAsRemovable = true;
        };
      };
    };
  }
