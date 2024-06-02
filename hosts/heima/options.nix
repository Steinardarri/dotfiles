# https://gitlab.com/Zaney/zaneyos/-/wikis/Setting-Options
let
  setUsername = "steinardth";
  setHostname = "heima";
  setSystemArchitecture = "x86_64-linux";
  setSystemDevice = "/dev/nvme0n1";
in {
  ## System ##

  # Base definitions
  username = "${setUsername}";
  hostname = "${setHostname}";
  system = "${setSystemArchitecture}";
  userHome = "/home/${setUsername}";
  flakeDir = "/home/${setUsername}/NixOS_Config";

  # Git Configuration
  gitUsername = "SteinarDarri";
  gitEmail = "steinar@steinardth.xyz";

  # System Settings
  clock24h = true;
  theLocale = "en_GB.UTF-8";
  theConsoleKeyMap = "is-latin1";
  theKBDLayout = "is";
  theSecondKBDLayout = "";
  theKBDVariant = "";
  theLCVariables = "is_IS.UTF-8";
  theTimezone = "Atlantic/Reykjavik";
  theShell = "zsh"; # bash, zsh
  theKernel = "xanmod"; # default, latest, lqx, xanmod, zen

  ## Hardware ##

  # Designation of device to install NixOS on
  device = "${setSystemDevice}";

  # For Hybrid Systems 'intel-nvidia' should Be Used As gpuType
  cpuType = "amd"; # amd, intel, vm
  gpuType = "amd"; # amd, intel, nvidia, intel-nvidia
  laptop = false;
  boot = "grub"; # disko, grub or noefi

  # Nvidia Hybrid Devices ONLY NEEDED FOR HYBRID SYSTEMS!
  intel-bus-id = "PCI:1:0:0";
  nvidia-bus-id = "PCI:0:2:0";

  # Declare nixos-hardware modules to use here
  hardware-list = [
    "common-cpu-amd"
    "common-cpu-amd-pstate"
    "common-cpu-amd-zenpower"
    "common-gpu-amd"
    "common-pc"
    "common-pc-ssd"
    "common-pc-hdd"
  ];

  # Enable Printer & Scanner Support
  printer = false;

  ## Programs

  # NFS
  nfs = false;
  nfsMountPoint = "/mnt/nas";
  nfsDevice = "nas:/volume1/nas";

  # Clock Settings
  ntp = true; # Network
  localHWClock = false;

  # Program Options
  browser = "floorp"; # Install & Set Default Browser
  terminal = "konsole"; # Set Default System Terminal
  distrobox = false;
  flatpak = false;

  gaming = true;
  work = false;

  logitech = true;

  # Terminals
  alacritty = false;
  kitty = false;

  syncthing = false;

  # Development
  python = true;
}
