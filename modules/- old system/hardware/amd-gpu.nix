{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    _hardware_amd_gpu.enable = lib.mkEnableOption "User-Defined AMD GPU Module";
  };

  config = lib.mkIf config._hardware_amd_gpu.enable {
    # Prefer radv over amdvlk
    hardware = {
      amdgpu = {
        initrd.enable = true;
        amdvlk.enable = false;
        overdrive = {
          enable = true;
          ppfeaturemask = "0xfffd7fff";
        };
        opencl.enable = true;
      };
      graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [
          vulkan-loader
          vulkan-validation-layers
          vulkan-extension-layer
        ];
      };
    };

    boot.kernelParams = [
      # Fixes white flickering after resume/unlock
      "amdgpu.sg_display=0"
    ];

    services.xserver.videoDrivers = ["amdgpu"];

    environment = {
      systemPackages = with pkgs; [
        clinfo
        vulkan-tools
      ];
      sessionVariables = {
        AMD_VULKAN_ICD = "RADV";
      };
    };

    systemd.tmpfiles.rules = [
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];
  };
}
