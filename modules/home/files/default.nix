{...}: {
  # Files to copy to home folder on install / rebuild

  home.file.".local/share/fonts" = {
    source = ./fonts;
    recursive = true;
  };
}
