{
  lib,
  username,
  ...
}: {
  fileSystems = {
    "/run/media/${username}/SSD_Kingston" = {
      label = "SSD_Kingston";
      fsType = "btrfs";
      options = ["defaults" "nofail" "noatime" "users" "exec" "compress=zstd:3"];
    };
    "/run/media/${username}/SSD" = {
      label = "SSD";
      fsType = "btrfs";
      options = ["defaults" "nofail" "noatime" "users" "exec" "compress=zstd:3"];
    };
    "/run/media/${username}/Hardur_Diskur" = {
      label = "Hardur_Diskur";
      fsType = "btrfs";
      options = ["defaults" "nofail" "noatime" "users" "compress=zstd:3"];
    };
    "/run/media/${username}/SteinarFlak" = {
      label = "SteinarFlak";
      fsType = "exfat";
      options = ["defaults" "nofail" "noatime" "users" "uid=1000" "gid=1001"];
    };
  };

  swapDevices = lib.mkForce [];
  zramSwap.enable = true;

  boot.kernelParams = [
    "video=DP-1:2560x1440@144"
    "video=DP-2:1920x1080@144"
    # Performance Stuff
    "rw"
    "nowatchdog"
    "nvme_load=YES"
    "rd.lvm=0"
    "rd.dm=0"
    "rd.md=0"
    "no_timer_check"
    "noreplace-smp"
    "threadirqs"
    "mitigations=off"
    "kernel.split_lock_mitigate=0"
  ];

  hardware = {
    xone.enable = true;
  };
}
