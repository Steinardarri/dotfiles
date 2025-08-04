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
      enable = false; # only need to run once
      wantedBy = ["network-online.target"];
      path = [pkgs.flatpak];
      script = ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
      '';
    };
  };
}
