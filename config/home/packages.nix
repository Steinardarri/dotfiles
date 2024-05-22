{pkgs, ...}: {
  home.packages = with pkgs; [
    # swww
    font-awesome
    spotify
    lapce
  ];
}
