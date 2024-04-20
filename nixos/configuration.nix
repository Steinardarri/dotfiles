{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        consoleMode = "auto";
      };
      efi.canTouchEfiVariables = true;
      timeout = 3;
    };
    initrd.luks.devices."luks-408d55bf-2ccf-4a3a-8bf6-e18de61188ce".device = "/dev/disk/by-uuid/408d55bf-2ccf-4a3a-8bf6-e18de61188ce";
  };

  nix.settings = {
    # Enable flakes and new 'nix' command
    experimental-features = "nix-command flakes";
    # Deduplicate and optimize nix store
    auto-optimise-store = true;
  };

  # This will add each flake input as a registry
  # To make nix3 commands consistent with your flake
  nix.registry = (lib.mapAttrs (_: flake: {inherit flake;})) ((lib.filterAttrs (_: lib.isType "flake")) inputs);

  # This will additionally add your inputs to the system's legacy channels
  # Making legacy nix commands consistent as well, awesome!
  nix.nixPath = ["/etc/nix/path"];
  environment.etc =
    lib.mapAttrs'
    (name: value: {
      name = "nix/path/${name}";
      value.source = value.flake;
    })
    config.nix.registry;

  # Networking
  networking = {
    hostName = "lappi";
    networkmanager.enable = true;
  };

  # Locale
  time.timeZone = "Atlantic/Reykjavik";
  i18n.defaultLocale = "en_GB.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "is_IS.UTF-8";
    LC_IDENTIFICATION = "is_IS.UTF-8";
    LC_MEASUREMENT = "is_IS.UTF-8";
    LC_MONETARY = "is_IS.UTF-8";
    LC_NAME = "is_IS.UTF-8";
    LC_NUMERIC = "is_IS.UTF-8";
    LC_PAPER = "is_IS.UTF-8";
    LC_TELEPHONE = "is_IS.UTF-8";
    LC_TIME = "is_IS.UTF-8";
  };

  console.keyMap = "is-latin1";

  ### Budgie ###

  # Enable the X11 windowing system
  services.xserver.enable = true;

  # Enable the Budgie Desktop environment
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.budgie.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "is";
    variant = "";
    options = "caps:swapescape";
  };
  services.xserver.libinput = {
    enable = true;
    naturalScrolling = false;
    middleEmulation = true;
    tapping = true;
  };

  # Enable CUPS to print documents
  services.printing.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;

  hardware = {
    bluetooth.enable = true;

    nvidia = {
      prime.offload.enable = false;
      modesetting.enable = true;
    };

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };

  # Enable sound with pipewire
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  users.users.steinardth = {
    isNormalUser = true;
    description = "Steinar Darri";
    openssh.authorizedKeys.keys = [
        # TODO: Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
    extraGroups = [ "networkmanager" "wheel" ];
  };

  services.displayManager.autoLogin = {
    enable = true;
    user = "steinardth";
  };

  # This setups a SSH server. Very important if you're setting up a headless system.
  # Feel free to remove if you don't need it.
  services.openssh = {
    enable = true;
    settings = {
      # Forbid root login through SSH.
      PermitRootLogin = "no";
      # Use keys only. Remove if you want to SSH using password (not recommended)
      PasswordAuthentication = false;
    };
  };

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  environment.systemPackages = with pkgs; [
    unzip
    just
    curl
    gparted
    barrier
  ];

  system.stateVersion = "23.11";

}
