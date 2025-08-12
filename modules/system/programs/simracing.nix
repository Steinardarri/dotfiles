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
      inputs.simracing-nix.packages.${pkgs.stdenv.hostPlatform.system}.monocoque
      inputs.simshmbridge.packages.${pkgs.stdenv.hostPlatform.system}.all
      # inputs.simshmbridge.packages.${pkgs.stdenv.hostPlatform.system}.simshmbridge-assettocorsa.overrideAttrs      (old: {
      #   # Rename exe for Crew Chief
      #   postInstall = ''
      #     mv $out/acbridge.exe $out/AC2-Win64-Shipping.exe
      #   '';
      # })
    ];
  };
}
