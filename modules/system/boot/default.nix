{...}: {
  imports = [
    ./diskoboot.nix
    ./grub-gpt.nix
    ./grub-noefi.nix
  ];

  boot = {
    loader = {
      grub = {
        enable = true;
        configurationLimit = 15;
        devices = ["nodev"];
      };
      timeout = 3;
    };
    plymouth.enable = true;
  };
}
