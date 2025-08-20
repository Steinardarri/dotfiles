{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: {
  options = {
    _simracing.enable = lib.mkEnableOption "User-Defined Sim Racing Module";
  };

  config = lib.mkIf (config._simracing.enable
    && config._gaming.enable) {
    environment.systemPackages = [
      inputs.jstest-gtk.packages.${pkgs.stdenv.hostPlatform.system}.jstest-gtk

      inputs.monocoque.packages.${pkgs.stdenv.hostPlatform.system}.default

      inputs.simshmbridge.packages.${pkgs.stdenv.hostPlatform.system}.simshmbridge

      inputs.simmonitor.packages.${pkgs.stdenv.hostPlatform.system}.default
      pkgs.postgresql
      pkgs.gnuplot
    ];

    # Cammus C5 Wheel Device
    services.udev.extraRules = ''
      SUBSYSTEM=="usb", ATTRS{idVendor}=="3416", ATTRS{idProduct}=="1021", MODE="0666"
      SUBSYSTEM=="hidraw", ATTRS{idVendor}=="3416", ATTRS{idProduct}=="1021", MODE="0666"
    '';

    networking.firewall = {
      allowedUDPPorts = [
        # ACC
        9000
      ];
    };
  };
}
