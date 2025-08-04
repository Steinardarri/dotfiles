_: {
  # Host specific network module

  networking = {
    domain = "steinardth.xyz";

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
      "9.9.9.9#dns.quad9.net"
      "149.112.112.112#dns.quad9.net"
      "2620:fe::fe#dns.quad9.net"
      "2620:fe::9#dns.quad9.net"
    ];

    enableIPv6 = false;
  };
}
