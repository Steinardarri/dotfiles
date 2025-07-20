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

  # Enables proprietary firmware for enhanced hardware support
  hardware.enableRedistributableFirmware = true;
}
