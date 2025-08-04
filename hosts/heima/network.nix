_: {
  # Host specific network module

  networking = {
    domain = "steinardth.xyz";

    nameservers = [
      "9.9.9.9#dns.quad9.net"
      "149.112.112.112#dns.quad9.net"
      "2620:fe::fe#dns.quad9.net"
      "2620:fe::9#dns.quad9.net"
    ];

    enableIPv6 = false;
  };
}
