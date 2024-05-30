{
  pkgs,
  lib,
  hostname,
  ...
}: let
  inherit (import ../../hosts/${hostname}/options.nix) python;
  my-python-packages = ps:
    with ps; [
      numpy
      pandas
      requests
    ];
in
  lib.mkIf (python == true) {
    environment.systemPackages = with pkgs; [
      (pkgs.python3.withPackages my-python-packages)
      ruff
      black
    ];
  }
