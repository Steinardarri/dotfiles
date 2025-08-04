{
  pkgs,
  lib,
  config,
  inputs,
  ...
}: let
  nixpkgs-hypr = inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
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
        package = nixpkgs-hypr.mesa;
        package32 = nixpkgs-hypr.pkgsi686Linux.mesa;
        extraPackages = with pkgs; [
          rocmPackages.clr.icd
        ];
      };
    };
    environment = {
      systemPackages = with pkgs; [
        vulkan-loader
        vulkan-validation-layers
        vulkan-tools
      ];
      sessionVariables = {
        AMD_VULKAN_ICD = "RADV";
        VK_ICD_FILENAMES = "${nixpkgs-hypr.mesa}/share/vulkan/icd.d/radeon_icd.x86_64.json";
      };
    };
    boot.kernelParams = [
      # Fixes white flickering after resume/unlock
      "amdgpu.sg_display=0"
    ];
  };
}
