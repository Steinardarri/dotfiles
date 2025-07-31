{...}: {
  # Enable the hardware module in the host default nix
  imports = [
    ./amd-gpu.nix
    ./intel-amd.nix
    # ./intel-gpu.nix
    # ./intel-nvidia.nix
    ./laptop.nix
    ./nvidia.nix
  ];

  hardware = {
    # Enables proprietary firmware for enhanced hardware support
    enableRedistributableFirmware = true;

    bluetooth = {
      enable = true;
      powerOnBoot = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          Experimental = true;
        };
      };
    };

    graphics.enable = true;
  };
}
