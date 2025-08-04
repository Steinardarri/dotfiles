{...}: {
  imports = [
    ./flatpak.nix
    ./jellyfin.nix
    ./lact.nix
    ./nemo.nix
  ];

  # Slows down boot time
  systemd.services.NetworkManager-wait-online.enable = false;

  services = {
    # DNS resolver
    resolved = {
      enable = true;
      dnsovertls = "true";
      dnssec = "true";
    };

    dbus.implementation = "broker";

    # Power
    logind.powerKey = "suspend";
    power-profiles-daemon.enable = true;
    upower.enable = true;

    atuin.enable = true;
  };
}
