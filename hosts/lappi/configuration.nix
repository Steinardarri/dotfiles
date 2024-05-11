{ pkgs, lib, inputs, ... }: {
  
  system.stateVersion = "23.11";

  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  boot.initrd.luks.devices."luks-e0d82684-c0f9-4a91-9c15-7739b2c849b7".device = "/dev/disk/by-uuid/e0d82684-c0f9-4a91-9c15-7739b2c849b7";

  networking.hostName = "lappi";

  systemd.tmpfiles.rules = [
    "d /home/steinardth/.config 0755 steinardth users"
  ];

  programs.zsh.enable = true;
  environment.pathsToLink = ["/share/zsh"];
  environment.shells = [pkgs.zsh];

  environment.enableAllTerminfo = true;

  security.sudo.wheelNeedsPassword = false;

  users.users.steinardth = {
    isNormalUser = true;
    description = "Steinar Darri Þorgilsson";
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
  services.xserver.displayManager.autoLogin.user = "steinardth";

  home-manager.users.steinardth = {
    imports = [
      ./home.nix
      inputs.nix-index-database.hmModules.nix-index
    ];
  };

  # virtualisation.docker = {
  #   enable = true;
  #   enableOnBoot = true;
  #   autoPrune.enable = true;
  # };

  nix = {
    settings = {
      trusted-users = [steinardth];
      accept-flake-config = true;
      auto-optimise-store = true;
      experimental-features = [ "nix-command" "flakes"];
    };

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };
}
