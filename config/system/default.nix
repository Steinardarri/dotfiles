{...}: {
  imports = [
    ./boot
    ./desktop
    ./driver
    ./kernel
    
    ./distrobox.nix
    ./flatpak.nix
    ./floorp.nix
    ./hwclock.nix
    ./logitech.nix
    ./nfs.nix
    ./ntp.nix
    ./packages.nix
    #./persistence.nix
    ./printer.nix
    ./python.nix
    ./services.nix
    ./steam.nix
    ./syncthing.nix
    ./vm.nix
  ];
}
