{...}: {
  disko.devices = {
    disk.main = {
      type = "disk";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            size = "1000M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = ["fmask=0137" "dmask=0027"];
            };
          };
          luks = {
            size = "100%";
            content = {
              type = "luks";
              name = "NixCrypt";
              # Allow discards from SSD TRIM
              settings.allowDiscards = true;
              # Set luks password during install
              askPassword = true;
              content = {
                type = "filesystem";
                format = "xfs";
                extraArgs = ["-L \"NixOS\""];
                mountpoint = "/";
                mountOptions = ["defaults" "noatime"];
              };
            };
          };
        };
      };
    };
  };
}
