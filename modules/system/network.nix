{lib, ...}: {
  networking = {
    networkmanager = {
      enable = lib.mkDefault true;
      dns = "systemd-resolved";
    };
    nftables.enable = true;
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
