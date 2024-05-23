{
  pkgs,
  lib,
  hostname,
  ...
}: let
  inherit (import ../../../hosts/${hostname}/options.nix) gpuType;
in
  lib.mkIf ("${gpuType}" == "amd") {
    systemd.tmpfiles.rules = [
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];
    services.xserver.enable = true;
    services.xserver.videoDrivers = ["amdgpu"];
    # OpenGL
    hardware.opengl = {
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
        rocmPackages.clr
        libva
        libva-utils
        #libvdpau-va-gl
        #vaapiVdpau
        vdpauinfo
        amdvlk
      ];
      extraPackages32 = with pkgs; [
        driversi686Linux.amdvlk
      ];
    };
    boot.initrd.kernelModules = ["amdgpu"];
  }
