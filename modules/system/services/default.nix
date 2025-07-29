{...}: {
  imports = [
    ./flatpak.nix
    ./jellyfin.nix
    ./lact.nix
  ];

  systemd.services.NetworkManager-wait-online.enable = false;
  services.resolved.enable = true;
}
