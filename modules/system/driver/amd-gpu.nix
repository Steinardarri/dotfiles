{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    _amd_gpu.enable = lib.mkEnableOption "User-Defined AMD GPU Module";
  };

  config = lib.mkIf config._amd_gpu.enable {
    systemd.tmpfiles.rules = [
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];
    hardware.amdgpu.amdvlk = {
      enable = false;
    };
    environment.systemPackages = with pkgs; [
      vulkan-tools
    ];
  };
}
