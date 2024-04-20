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

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

  # Enable CUPS to print documents
  services.printing.enable = true;

  # Enable bluetooth
  hardware.bluetooth.enable = true;

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
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      opera
    ];
  };

  services.displayManager.autoLogin = {
    enable = true;
    user = "steinardth";
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    git
    unzip
    just
    curl
    gparted
    barrier
  ];

  system.stateVersion = "23.11";

}
