{
  hostname,
  lib,
  ...
}: let
  inherit (import ../../../hosts/${hostname}/options.nix) boot;
in
  lib.mkIf ("${boot}" == "noefi") {
    # Used to have declarations but they got generalized
    # Still useful to designate for VMs, and could get settings
    boot = {
      loader = {
        grub = {
        };
      };
    };
  }
