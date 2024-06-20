{pkgs, ...}: {
  imports = [
    ./desktop
    ./shell
    ./terminal

    ./files.nix

    #./browser.nix
    ./floorp.nix
    ./helix.nix
    ./personal.nix
    ./spicetify.nix
    ./vscodium.nix
  ];

  home.packages = with pkgs; [
    # swww
    lapce
  ];
}
