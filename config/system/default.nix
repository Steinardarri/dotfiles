{...}: {
  imports = [
    ./amd-gpu.nix
    ./boot-gpt.nix
    ./boot-noefi.nix
    ./displaymanager.nix
    ./distrobox.nix
    ./flatpak.nix
    ./hwclock.nix
    ./impermanence
    ./intel-amd.nix
    ./intel-gpu.nix
    ./intel-nvidia.nix
    ./kernel.nix
    ./laptop.nix
    ./logitech.nix
    ./nfs.nix
    ./ntp.nix
    ./nvidia.nix
    ./packages.nix
    ./printer.nix
    ./python.nix
    ./services.nix
    ./steam.nix
    ./syncthing.nix
    ./vm.nix
  ];
}
