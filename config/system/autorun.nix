{
  pkgs,
  config,
  username,
  hostname,
  ...
}: let
  inherit (import ../../hosts/${hostname}/options.nix) wallpaperDir wallpaperGit;
in {
  # system.userActivationScripts = {
  #   gitwallpapers.text = ''
  #   '';
  # };
}
