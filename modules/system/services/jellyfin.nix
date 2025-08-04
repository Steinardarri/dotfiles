{
  lib,
  config,
  pkgs,
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

    environment.systemPackages = with pkgs; [
      jellyfin-ffmpeg
    ];

    users.users.jellyfin.extraGroups = [
      "video"
      "render"
    ];
  };
}
