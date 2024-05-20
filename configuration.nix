{pkgs, ...}: {
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
  services.xserver.displayManager.sddm.enable = true;
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

  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "steinardth";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.channel = "unstable";

  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    helix
    neofetch
    toybox

    floorp
    vscodium-fhs

    nil
    alejandra
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  environment.variables = {
    EDITOR = "hx";
  };

  system.stateVersion = "23.11";
}
