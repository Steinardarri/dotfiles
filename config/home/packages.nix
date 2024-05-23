{pkgs, ...}: {
  home.packages = with pkgs; [
    # swww
    font-awesome
    spotify
    spicetify-cli
    lapce
  ];
}
