{pkgs, ...}: {
  imports = [
    ./desktop
    ./shell
    ./terminal

    ./files.nix
    #./persistence.nix

    #./browser.nix #Doesn't work with floorp
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
