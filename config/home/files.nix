{...}: {
  home.file.".local/share/fonts" = {
    source = ./files/fonts;
    recursive = true;
  };
}
