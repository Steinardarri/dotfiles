{
  lib,
  pkgs,
  username,
  hostname,
  ...
}: let
  inherit (import ../../../hosts/${hostname}/options.nix) printer;
in
  lib.mkIf (printer == true) {
    services = {
      printing.enable = true;
      avahi = {
        enable = true;
        nssmdns4 = true;
        openFirewall = true;
      };
      ipp-usb.enable = true;
    };
    hardware.sane = {
      enable = true;
      extraBackends = [pkgs.sane-airscan];
      disabledDefaultBackends = ["escl"];
    };
    programs.system-config-printer.enable = true;
    users.users.${username}.extraGroups = ["scanner" "lp"];
  }
