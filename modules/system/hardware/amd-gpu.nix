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
    systemd.tmpfiles.rules = [
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];

    hardware.amdgpu = {
      initrd.enable = true;
      amdvlk.enable = false;
      overdrive = {
        enable = true;
        ppfeaturemask = "0xfffd7fff";
      };
      opencl.enable = true;
    };

    environment.systemPackages = with pkgs; [
      vulkan-tools
    ];
  };
}
