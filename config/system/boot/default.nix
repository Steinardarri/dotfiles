{...}: {
  imports = [
    ./disko.nix
    ./diskoboot.nix
    ./grub-gpt.nix
    ./grub-noefi.nix
    ./persistence.nix
  ];
}
