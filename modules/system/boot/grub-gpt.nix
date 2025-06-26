{
  hostname,
  lib,
  ...
}: let
  inherit (import ../../../hosts/${hostname}/options.nix) boot;
in
  lib.mkIf ("${boot}" == "default") {
    boot = {
      loader = {
        efi = {
          efiSysMountPoint = "/boot";
          canTouchEfiVariables = true;
        };
        grub = {
          efiSupport = true;
        };
      };
    };
  }
