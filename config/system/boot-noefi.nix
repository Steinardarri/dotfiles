{
  pkgs,
  config,
  hostname,
  lib,
  ...
}: let
  inherit (import ../../hosts/${hostname}/options.nix) boot;
in
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
