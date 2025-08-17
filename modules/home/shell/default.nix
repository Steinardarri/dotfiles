{inputs, ...}: {
  imports = [
    inputs.nix-index-database.homeModules.nix-index

    ./fish
    ./fastfetch

    ./starship.nix
    ./zsh.nix
  ];

  programs.direnv = {
    enable = true;
    silent = true;
    nix-direnv.enable = true;
    config = {
      global = {
        load_dotenv = true;
      };
      whitelist = {
        prefix = [
          "~/Forrit"
          "~/Verkefni"
          "~/.steam/root/"
          "~/.local/share/Steam"
        ];
      };
    };
  };
}
