{pkgs, ...}: {
  imports = [
    ./yazi

    ./helix.nix
    ./zellij.nix
  ];

  home.packages = with pkgs; [
    mpc
  ];
}
