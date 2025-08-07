{pkgs, ...}: {
  imports = [
    ./gaming.nix
    ./nano.nix
  ];

  programs = {
    partition-manager.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-media-tags-plugin
        thunar-vcs-plugin
        thunar-volman
      ];
    };
  };
}
