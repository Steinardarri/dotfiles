{lib, ...}: {
  # Host specific network module

  networking = {
    # Disable NetworkManager's internal DNS resolution
    networkmanager = {
      insertNameservers = [
        "192.168.31.43"
      ];
      # dns = lib.mkForce "none";
    };

    # These options are unnecessary when managing DNS ourselves
    # interfaces.enp6s0.useDHCP = false;
    # dhcpcd.enable = false;
    # useDHCP = false;

    enableIPv6 = false;
    # nftables.enable = lib.mkForce false;
  };
  # services.resolved.enable = lib.mkForce false;
}
