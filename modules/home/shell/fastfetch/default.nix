{...}: {
  programs.fastfetch = {
    enable = true;

    settings = builtins.fromJSON (builtins.readFile ./settings.jsonc);
  };
}
