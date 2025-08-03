{...}: {
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
    };
  };
}
