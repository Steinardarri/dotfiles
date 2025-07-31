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
        extraPackages = with pkgs; [
          rocmPackages.clr.icd
        ];
        enable32Bit = true;
      };
    };
    environment = {
      systemPackages = with pkgs; [
        vulkan-tools
      ];
      sessionVariables = {
        AMD_VULKAN_ICD = "RADV";
      };
    };
    boot.kernelParams = [
      # Fixes white flickering after resume/unlock
      "amdgpu.sg_display=0"
    ];
  };
}
