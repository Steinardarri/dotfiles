{...}: {
  imports = [
    ./shell
    ./terminal

    ./files.nix

    #./browser.nix #Doesn't work with floorp
    ./helix.nix
    ./floorp.nix
    ./packages.nix
    #./persistence.nix
    ./personal.nix
    ./vscodium.nix
  ];
}
