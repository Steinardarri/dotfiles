{
  lib,
  hostname,
  username,
  ...
}: let
  inherit (import ../../hosts/${hostname}/options.nix) syncthing;
in
  lib.mkIf (syncthing == true) {
    services = {
      syncthing = {
        enable = true;
        user = "${username}";
        dataDir = "/home/${username}"; # Default folder for new synced folders
        configDir = "/home/${username}/.config/syncthing"; # Folder for Syncthing's settings and keys
      };
    };
  }
