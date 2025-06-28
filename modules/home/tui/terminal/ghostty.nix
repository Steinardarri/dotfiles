{
  pkgs,
  inputs,
  hostname,
  ...
}: let
  inherit
    (import ../../../hosts/${hostname}/options.nix)
    theShell
    ;
in {
  programs.ghostty = {
    enable = true;
    package = inputs.ghostty.packages.${pkgs.stdenv.hostPlatform.system}.default;

    settings = {
      font-family = "Hack NF FC Ligatured CCG";
      font-size = 12;

      command = "${theShell}";

      window-decoration = false;
      window-padding-x = 10;
      window-padding-y = 10;

      confirm-close-surface = false;
      shell-integration-features = "cursor,sudo,title";

      copy-on-select = false;
    };
  };
}
