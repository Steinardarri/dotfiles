{...}: {
  imports = [
    ./shell
    ./terminal

    #./browser.nix #Doesn't work with floorp
    ./helix.nix
    ./packages.nix
    ./personal.nix
    ./vscodium.nix
  ];
}
