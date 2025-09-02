{pkgs, ...}: {
  networking = {
    networkmanager = {
      enable = true;
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

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];

  services.resolved.enable = true;
}
