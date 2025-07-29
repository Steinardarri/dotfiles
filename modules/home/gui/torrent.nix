{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    _torrent.enable = lib.mkEnableOption "User-Defined Torrent Module";
  };

  config = lib.mkIf config._torrent.enable {
    home.packages = with pkgs; [
      kdePackages.ktorrent
    ];
  };
}
