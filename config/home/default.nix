{pkgs, ...}: {
  imports = [
    ./shell
    ./terminal

    ./files.nix

    #./browser.nix #Doesn't work with floorp
    ./floorp.nix
    ./helix.nix
    #./persistence.nix
    ./personal.nix
    ./vscodium.nix
  ];

  home.packages = with pkgs; [
    # swww
    font-awesome
    spotify
    spicetify-cli
    lapce
  ];
}
