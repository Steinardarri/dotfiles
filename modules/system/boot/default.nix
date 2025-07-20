{lib, ...}: {
  boot = {
    loader = {
      grub = {
        enable = lib.mkOptionDefault true;
        configurationLimit = 15;
        devices = ["nodev"];
      };
      timeout = lib.mkDefault 3;
    };
    plymouth.enable = true;
  };
}
