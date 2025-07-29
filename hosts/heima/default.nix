{
  pkgs,
  username,
  hostname,
  secrets,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./extra-hardware.nix
    ./network.nix
  ];

  ### Custom System Modules From modules/system - to enable

  _hardware_amd_gpu.enable = true;
  _gaming.enable = true;
  _jellyfin.enable = true;
  _flatpak.enable = true;
  _lact.enable = true;

  ###

  networking.hostName = hostname;

  users = {
    users.${username} = {
      isNormalUser = true;
      homeMode = "755";
      # Secrets handled by git-crypt, from flake input
      hashedPassword = "${secrets.hashed_user_password}";
      description = "Steinar Darri Þorgilsson";
      extraGroups = [
        "wheel"
        "networkmanager"
        "audio"
        "render"
        "video"
        "gamemode"
        "media"
      ];
      # Zsh used as login shell then initializes fish
      # https://nixos.wiki/wiki/Fish#Setting_fish_as_your_shell
      shell = pkgs.zsh;
    };
    mutableUsers = false;
  };
  services.getty.autologinUser = username;

  # Whether you need to input password on sudo
  security.sudo.wheelNeedsPassword = false;
}
