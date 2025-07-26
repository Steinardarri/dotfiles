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
  _torrent.enable = true;

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
        "video"
      ];
      shell = pkgs.fish;
    };
    mutableUsers = false;
  };

  # Whether you need to input password on sudo
  security.sudo.wheelNeedsPassword = true;
}
