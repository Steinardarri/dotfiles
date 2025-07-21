{...}: {
  imports = [
    ./flatpak.nix
    ./jellyfin.nix
  ];

  systemd.services.NetworkManager-wait-online.enable = false;
  services.resolved.enable = true;
}
