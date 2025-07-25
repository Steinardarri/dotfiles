{pkgs, ...}: {
  # Host specific network module

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];

  networking = {
    networkmanager.enable = true;
    enableIPv6 = false;
    firewall.enable = true;
  };
}
