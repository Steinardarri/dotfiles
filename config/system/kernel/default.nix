{...}: {
  imports = [
    ./latest.nix
    ./lqx.nix
    ./vanilla.nix
    ./xanmod.nix # My choice
    ./zen.nix

    # For the adventurous people
    # It's not listed in the list of possible options,
    # but the ones who want to try it can do so.
    ./testing.nix
  ];
}
