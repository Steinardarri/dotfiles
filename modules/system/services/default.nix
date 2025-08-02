{...}: {
  imports = [
    ./flatpak.nix
    ./jellyfin.nix
    ./lact.nix
  ];

  # DNS resolver
  services.resolved = {
    enable = true;
    dnsovertls = "true";
    dnssec = "true";
  };

  # Slows down boot time
  systemd.services.NetworkManager-wait-online.enable = false;

  services.dbusimplementation = "broker";
}
