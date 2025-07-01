{...}: {
  imports = [
    ./hwclock.nix
    ./logitech.nix
    ./ntp.nix
    ./printer.nix
    ./services.nix
    ./vm.nix
  ];

  zramSwap.enable = true;
}
