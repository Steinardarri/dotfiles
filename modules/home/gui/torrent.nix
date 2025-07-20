{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    _torrent.enable = lib.mkEnableOption "User-Defined Torrent Home Module";
  };

  config = lib.mkIf config._torrent.enable {
    home.packages = with pkgs; [
      kdePackages.ktorrent
    ];
  };
}
