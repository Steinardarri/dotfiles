{
  pkgs,
  hostname,
  ...
}: let
  inherit (import ../../hosts/${hostname}/options.nix) flakeDir;
in
  pkgs.writeShellScriptBin "themechange" ''
    if [[ ! $@ ]];then
      echo "No Theme Given"
    else
      replacement="$1"
      sed -i "/^\s*theme[[:space:]]*=[[:space:]]*\"/s/\"\(.*\)\"/\"$replacement\"/" ${flakeDir}/hosts/${hostname}/options.nix
      kitty -e pkexec nixos-rebuild switch --flake ${flakeDir}
    fi
  ''
