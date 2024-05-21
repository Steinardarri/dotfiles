{...}: {
  home.file.".local/share/fonts" = {
    source = ./files/fonts;
    recursive = true;
  };
  home.file.".config/starship.toml".source = ./files/starship.toml;
}
