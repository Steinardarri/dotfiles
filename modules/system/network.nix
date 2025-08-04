_: {
  networking = {
    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
    };
    firewall = {
      enable = true;

      allowedTCPPorts = [
        # Spotify
        4070
        57621
      ];
      allowedUDPPorts = [
        # Spotify
        5353
      ];
    };
  };
}
