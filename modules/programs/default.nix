{username, ...}: {
  imports = [
    ./git.nix
    ./python.nix
  ];

  programs = {
    nh = {
      enable = true;
      clean = {
        enable = true;
        dates = "weekly";
        extraArgs = "--keep-since 14d --keep 15";
      };
      flake = "/home/${username}/dotfiles";
    };
  };
}
