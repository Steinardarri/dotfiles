{ config, pkgs, lib, username, ... }: {
  
  system.stateVersion = "23.11";

  imports = [
    ./hardware-configuration.nix
  ];

  boot.initrd.luks.devices."luks-e0d82684-c0f9-4a91-9c15-7739b2c849b7".device = "/dev/disk/by-uuid/e0d82684-c0f9-4a91-9c15-7739b2c849b7";

  systemd.tmpfiles.rules = [
    "d /home/${username}/.config 0755 ${username} users"
  ];

  # security.sudo.wheelNeedsPassword = false;

  users.users.${username} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    # add your own hashed password
    # hashedPassword = "";
    # add your own ssh public key
    # openssh.authorizedKeys.keys = [
    #   "ssh-rsa ..."
    # ];
  };

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = ${username};

  home-manager.users.${username} = {
    imports = [
      ./home.nix
    ];
  };

  # virtualisation.docker = {
  #   enable = true;
  #   enableOnBoot = true;
  #   autoPrune.enable = true;
  # };

  ### Budgie ###

  # Enable the X11 windowing system
  services.xserver.enable = true;

  # Enable the Budgie Desktop environment
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.budgie.enable = true;

}
