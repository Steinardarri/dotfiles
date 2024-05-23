{...}: {
  imports = [
    ./shell
    ./terminal
    
    #./browser.nix
    ./helix.nix
    ./packages.nix
    ./personal.nix
    ./vscodium.nix

    # Place Home Files Like Pictures
    ./files.nix
  ];
}
