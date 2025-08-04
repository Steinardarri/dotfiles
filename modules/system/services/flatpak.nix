{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    _flatpak.enable = lib.mkEnableOption "User-Defined Flatpak Module";
  };

  config = lib.mkIf config._flatpak.enable {
    services.flatpak.enable = true;

    systemd.services.flatpak-repo = {
      wantedBy = ["multi-user.target" "network-online.target"];
      path = [pkgs.flatpak];
      script = ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
    };
  };
}
