{username, ...}: {
  fileSystems = {
    "/run/media/${username}/SSD_Kingston" = {
      device = "/dev/disk/by-label/SSD_Kingston";
      fsType = "btrfs";
      options = ["defaults,nofail,noatime,users,exec,compress=zstd:3"];
      nocheck = true;
    };
    "/run/media/${username}/SSD" = {
      device = "/dev/disk/by-label/SSD";
      fsType = "btrfs";
      options = ["defaults,nofail,noatime,users,exec,compress=zstd:3"];
      nocheck = true;
    };
    "/run/media/${username}/Steam" = {
      device = "/dev/disk/by-label/Steam";
      fsType = "btrfs";
      options = ["defaults,nofail,noatime,users,exec,compress=zstd:3"];
      nocheck = true;
    };
    "/run/media/${username}/Hardur_Diskur" = {
      device = "/dev/disk/by-label/Hardur_Diskur";
      fsType = "btrfs";
      options = ["defaults,nofail,noatime,users,compress=zstd:3"];
      nocheck = true;
    };
    "/run/media/${username}/SteinarFlak" = {
      device = "/dev/disk/by-label/SteinarFlak";
      fsType = "exfat";
      options = ["defaults,nofail,noatime,users,exec,uid=1000,gid=1001"];
    };
  };

  boot.kernelParams = [
    "video=DP-1:1920x1080@144"
    "video=DP-2:2560x1440@144"
  ];
}
