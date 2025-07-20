{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    _intel_gpu.enable = lib.mkEnableOption "User-Defined Intel GPU Module";
  };

  config = lib.mkIf config._intel_gpu.enable {
    nixpkgs.config.packageOverrides = pkgs: {
      vaapiIntel = pkgs.vaapiIntel.override {
        enableHybridCodec = true;
      };
    };

    # OpenGL
    hardware.opengl = {
      extraPackages = with pkgs; [
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };
}
