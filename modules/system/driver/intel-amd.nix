{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    _intel_amd.enable = lib.mkEnableOption "User-Defined Intel CPU AMD GPU Module";
  };

  config = lib.mkIf config._intel_amd.enable {
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
        amdvlk
      ];
      extraPackages32 = [pkgs.driversi686Linux.amdvlk];
    };

    systemd.tmpfiles.rules = [
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];
    services.xserver.enable = true;
    services.xserver.videoDrivers = ["amdgpu"];
  };
}
