{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    inputs.hardware.nixosModules.common-pc-laptop
    inputs.hardware.nixosModules.common-pc-laptop-ssd
    inputs.hardware.nixosModules.common-cpu-intel-cpu-only
    inputs.hardware.nixosModules.common-gpu-nvidia

    ./hardware-configuration.nix
  ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
      };
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };
    initrd.luks.devices."luks-408d55bf-2ccf-4a3a-8bf6-e18de61188ce".device = "/dev/disk/by-uuid/408d55bf-2ccf-4a3a-8bf6-e18de61188ce";
  };

  networking = {
    hostName = "lappi";
  };

  # Touchpad
  services.xserver.libinput = {
    enable = true;
    naturalScrolling = false;
    middleEmulation = true;
    tapping = true;
  };

  hardware = {
    bluetooth.enable = true;

    nvidia = {
      modesetting.enable = true;
    };

  # nvidia = {
  #   open = false;
  #   modesetting.enable = true;
  #   prime = {
  #     offload.enable = true;
  #     intelBusId  = "PCI:0:2:0";
  #     nvidiaBusId = "PCI:1:0:0";
  #   };
  #   nvidiaPersistenced = false;
  # };

    enableRedistributableFirmware = true;
    cpu.intel.updateMicrocode = true;

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  system.stateVersion = "23.11";

}
