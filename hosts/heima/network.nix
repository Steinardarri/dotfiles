{lib, ...}: {
  # Host specific network module

  networking = {
    # Disable NetworkManager's internal DNS resolution
    networkmanager.dns = lib.mkForce "none";

    # These options are unnecessary when managing DNS ourselves
    dhcpcd.enable = false;
    useDHCP = false;

    # Configure DNS servers manually
    nameservers = [
      "192.168.31.43"
    ];

    enableIPv6 = false;
  };
  services.resolved.enable = lib.mkForce false;
}
