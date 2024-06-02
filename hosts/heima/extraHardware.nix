{username, ...}: {
  fileSystems."/run/media/${username}/SSD_M.2" = {
    device = "/dev/disk/by-uuid/5E2C71942C7167C3";
    fsType = "ntfs";
    options = ["nofail"];
  };
  fileSystems."/run/media/${username}/SSD" = {
    device = "/dev/disk/by-uuid/C26CA4BB6CA4AB9B";
    fsType = "ntfs";
    options = ["nofail"];
  };
  fileSystems."/run/media/${username}/SSD_Auka" = {
    device = "/dev/disk/by-uuid/6E1EB57E1EB53FBF";
    fsType = "ntfs";
    options = ["nofail"];
  };
  fileSystems."/run/media/${username}/Flakkari" = {
    device = "/dev/disk/by-uuid/48D4A622D4A6126C";
    fsType = "ntfs";
    options = ["nofail"];
  };
  fileSystems."/run/media/${username}/Hardur_Diskur" = {
    device = "/dev/disk/by-uuid/A052872852870270";
    fsType = "ntfs";
    options = ["nofail"];
  };

  boot.kernelParams = [
    "video=DP-1:1920x1080@144"
    "video=DP-2:2560x1440@144"
    "video=DP-3:1920x1080@60"
  ];
}
