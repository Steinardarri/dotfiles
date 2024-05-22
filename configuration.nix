{pkgs, ...}: {
  # Vanilla NixOS with Plasma 5 Desktop Environment

  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = ["nix-command" "flakes"];

  boot = {
    loader = {
      efi = {
        efiSysMountPoint = "/boot";
        canTouchEfiVariables = true; # XOR
      };
      grub = {
        enable = true;
        devices = ["nodev"];
        # efiInstallAsRemovable = true; # XOR
        efiSupport = true;
        useOSProber = true;
        configurationLimit = 10;
      };
      timeout = 3;
    };
  };

  networking.hostName = "heima";

  networking.networkmanager.enable = true;

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

  # Plasma
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "steinardth";
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.xkb = {
    layout = "is";
    variant = "";
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.steinardth = {
    isNormalUser = true;
    description = "Steinar Darri Þorgilsson";
    extraGroups = ["networkmanager" "wheel"];
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.channel = "unstable";

  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    helix
    fastfetch
    toybox

    # Flake utils
    nh
    nix-output-monitor
    nvd

    floorp
    vscodium-fhs

    nil
    alejandra

    # Plasma
    libsForQt5.kate
    libsForQt5.kgpg
    pinentry
    libsForQt5.ksshaskpass
    libsForQt5.kcalc
    libsForQt5.filelight
    libsForQt5.ksystemlog
    libsForQt5.spectacle
  ];
  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
    oxygen
  ];

  environment.variables = {
    SSH_ASKPASS = "${pkgs.libsForQt5.ksshaskpass.out}/bin/ksshaskpass";
    SSH_ASKPASS_REQUIRE = "prefer";
    EDITOR = "hx";
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  system.stateVersion = "23.11";
}
