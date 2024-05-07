{
  # uncomment the next line if you want to reference your GitHub/GitLab access tokens and other secrets
  secrets,
  username,
  hostname,
  pkgs,
  inputs,
  nix-index-database,
  nixvim,
  sops-nix,
  ...
}: {

  imports = [
    ./programs.nix
    ./services.nix
  ];

  time.timeZone = "Atlantic/Reykjavik";

  networking.hostName = "${hostname}";

  systemd.tmpfiles.rules = [
    "d /home/${username}/.config 0755 ${username} users"
  ];

  programs.zsh.enable = true;
  environment.pathsToLink = ["/share/zsh"];
  environment.shells = [pkgs.zsh];

  environment.enableAllTerminfo = true;

  security.sudo.wheelNeedsPassword = false;

  users.users.${username} = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "docker"
    ];
    # add your own hashed password
    # hashedPassword = "";
    # add your own ssh public key
    # openssh.authorizedKeys.keys = [
    #   "ssh-rsa ..."
    # ];
  };

  environment.systemPackages = [
    (import ./win32yank.nix {inherit pkgs;})
  ];

  home-manager.users.${username} = {
    imports = [
      ./home.nix
      nixvim.homeManagerModules.nixvim
      nix-index-database.hmModules.nix-index
      sops-nix.homeManagerModules.sops
    ];
  };

  system.stateVersion = "23.11";

  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    wslConf.interop.appendWindowsPath = false;
    wslConf.network.generateHosts = false;
    defaultUser = username;
    startMenuLaunchers = true;

    # Enable integration with Docker Desktop (needs to be installed)
    docker-desktop.enable = false;
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
  };

  # uncomment the next block to make vscode running in Windows "just work" with NixOS on WSL
  # solution adapted from: https://github.com/K900/vscode-remote-workaround
  # more information: https://github.com/nix-community/NixOS-WSL/issues/238 and https://github.com/nix-community/NixOS-WSL/issues/294
  systemd.user = {
    paths.vscode-remote-workaround = {
      wantedBy = ["default.target"];
      pathConfig.PathChanged = "%h/.vscode-server/bin";
    };
    services.vscode-remote-workaround.script = ''
      for i in ~/.vscode-server/bin/*; do
        if [ -e $i/node ]; then
          echo "Fixing vscode-server in $i..."
          ln -sf ${pkgs.nodejs_18}/bin/node $i/node
        fi
      done
    '';
  };

  nix = {
    settings = {
      trusted-users = [username];
      # use your access tokens from secrets.json here to be able to clone private repos on GitHub and GitLab
      access-tokens = [
        "github.com=${secrets.github_token}"
      ];

      accept-flake-config = true;
      auto-optimise-store = true;
    };

    registry = {
      nixpkgs = {
        flake = inputs.nixpkgs;
      };
    };

    nixPath = [
      "nixpkgs=${inputs.nixpkgs.outPath}"
      "nixos-config=/etc/nixos/configuration.nix"
      "/nix/var/nix/profiles/per-user/root/channels"
    ];

    package = pkgs.nixFlakes;
    extraOptions = ''experimental-features = nix-command flakes'';

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };
}
