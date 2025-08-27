_: {
  # Host specific network module

  networking = {
    networkmanager.enable = false;

    dhcpcd.enable = false;
    useDHCP = false;
    useNetworkd = true;

    interfaces.enp6s0 = {
      ipv4.addresses = [
        {
          address = "192.168.31.12";
          prefixLength = 24;
        }
      ];
    };
    defaultGateway = {
      address = "192.168.31.1";
      interface = "enp6s0";
    };

    nameservers = [
      "192.168.31.43"
    ];

    enableIPv6 = false;
  };
  services.resolved.enable = true;
}
