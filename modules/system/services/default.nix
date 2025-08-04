{...}: {
  imports = [
    ./flatpak.nix
    ./jellyfin.nix
    ./lact.nix
    ./nemo.nix
  ];

  # DNS resolver
  services.resolved = {
    enable = true;
    dnsovertls = "true";
    dnssec = "true";
  };

  # Slows down boot time
  systemd.services.NetworkManager-wait-online.enable = false;

  services = {
    dbus.implementation = "broker";

    # Power
    logind.powerKey = "suspend";
    power-profiles-daemon.enable = true;
    upower.enable = true;
  };
}
