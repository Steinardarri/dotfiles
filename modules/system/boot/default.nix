{lib, ...}: {
  imports = [
    ./diskoboot.nix
    ./grub-gpt.nix
    ./grub-noefi.nix
  ];

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
