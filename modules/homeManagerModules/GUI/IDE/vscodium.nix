{ config, pkgs, lib, ... }: {

  options = {
    vscodium.enable = 
      lib.mkEnableOption "Enable VSCodium";
  };

  config = lib.mkIf config.vscodium.enable {
    
  };
}