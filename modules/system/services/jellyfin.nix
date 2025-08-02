{
  lib,
  config,
  ...
}: {
  options = {
    _jellyfin.enable = lib.mkEnableOption "User-Defined Jellyfin Module";
  };

  config = lib.mkIf config._jellyfin.enable {
    services.jellyfin = {
      enable = true;
      openFirewall = true;
    };

    users.users.jellyfin.extraGroups = [
      "video"
      "render"
    ];

    networking.firewall = {
      allowedTCPPorts = [
        8096 # http traffic
      ];

      allowedUDPPorts = [
        1900 # service discovery
        7359 # client discovery
      ];
    };
  };
}
