{...}: {
  # Use nixos-hardware in the system flake as well
  # Some options from there are omitted here
  # Also, try not to overwrte your generated nixos-hardware config file
  # imports = [
  #   ./amd-gpu.nix
  #   ./intel-amd.nix
  #   ./intel-gpu.nix
  #   ./intel-nvidia.nix
  #   ./laptop.nix
  #   ./nvidia.nix
  # ];
  # Enables proprietary firmware for enhanced hardware support
  hardware.enableRedistributableFirmware = true;
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = true; # powers up the default Bluetooth controller on boot
}
