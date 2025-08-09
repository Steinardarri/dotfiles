{
  pkgs,
  username,
  ...
}: {
  imports = [
    ./flatpak.nix
    ./jellyfin.nix
    ./lact.nix
  ];

  # Slows down boot time
  systemd.services.NetworkManager-wait-online.enable = false;

  services = {
    dbus = {
      enable = true;
      packages = with pkgs; [
        gcr
        gnome-settings-daemon
      ];
      implementation = "broker";
    };
    openssh = {
      enable = true;
      ports = [5445];
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        AllowUsers = ["${username}"];
      };
    };
    udisks2 = {
      enable = true;
      mountOnMedia = true;
    };
    # DNS resolver
    resolved = {
      enable = true;
      dnsovertls = "true";
      dnssec = "true";
    };
    gvfs.enable = true;
    atuin.enable = true;
    # Power
    logind.powerKey = "suspend";
    power-profiles-daemon.enable = true;
    upower.enable = true;
  };
}
