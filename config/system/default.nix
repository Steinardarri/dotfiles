{...}: {
  imports = [
    ./boot
    ./desktop
    ./driver
    ./hardware
    ./kernel

    ./distrobox.nix
    ./flatpak.nix
    ./packages.nix
    ./python.nix
    ./steam.nix
    ./syncthing.nix
  ];
}
