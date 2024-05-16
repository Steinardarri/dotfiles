{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium.fhs;
  };
}
