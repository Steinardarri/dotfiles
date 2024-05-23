{
  config,
  lib,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "uas" "usbhid" "usb_storage" "sd_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-amd"];
  boot.extraModulePackages = [];

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/4E0A-9495";
    fsType = "vfat";
  };
  # Main Disk
  boot.initrd.luks.devices."luks-3ca7218a-2f4e-4c54-9951-4e4e98b74be7".device = "/dev/disk/by-uuid/3ca7218a-2f4e-4c54-9951-4e4e98b74be7";
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/5b17be92-6e34-4376-a483-27eb1a0a233f";
    fsType = "ext4";
  };
  # Swap on Main, with hibernate
  boot.initrd.luks.devices."luks-d0dc3f4a-c434-49a0-b3f4-0f3d8bba0c1c".device = "/dev/disk/by-uuid/d0dc3f4a-c434-49a0-b3f4-0f3d8bba0c1c";
  swapDevices = [
    {device = "/dev/disk/by-uuid/5aee75fc-f3e5-4a40-8e0e-8e92eee7fc3c";}
  ];
  # Extra
  fileSystems."/run/media/steinardth/SSD_M.2" = {
    device = "/dev/disk/by-uuid/5E2C71942C7167C3";
    fsType = "ntfs";
    options = ["nofail"];
  };
  fileSystems."/run/media/steinardth/SSD" = {
    device = "/dev/disk/by-uuid/C26CA4BB6CA4AB9B";
    fsType = "ntfs";
    options = ["nofail"];
  };
  fileSystems."/run/media/steinardth/SSD_Auka" = {
    device = "/dev/disk/by-uuid/6E1EB57E1EB53FBF";
    fsType = "ntfs";
    options = ["nofail"];
  };
  fileSystems."/run/media/steinardth/Flakkari" = {
    device = "/dev/disk/by-uuid/48D4A622D4A6126C";
    fsType = "ntfs";
    options = ["nofail"];
  };
  fileSystems."/run/media/steinardth/Hardur_Diskur" = {
    device = "/dev/disk/by-uuid/A052872852870270";
    fsType = "ntfs";
    options = ["nofail"];
  };

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
