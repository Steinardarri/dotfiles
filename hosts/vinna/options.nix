# PLEASE READ THE WIKI FOR DETERMINING
# WHAT TO PUT HERE AS OPTIONS.
# https://gitlab.com/Zaney/zaneyos/-/wikis/Setting-Options
let
  setUsername = "steinardth";
  setHostname = "vinna";
  setArchitecture = "x86_64-linux";
in {
  username = "${setUsername}";
  hostname = "${setHostname}";
  architecture = "${setArchitecture}";
  userHome = "/home/${setUsername}";
  flakeDir = "/home/${setUsername}/NixOS_Config";

  # Git Configuration ( For Pulling Software Repos )
  gitUsername = "Steinar Darri Þorgilsson";
  gitEmail = "steinar@brennisteinn.is";

  # System Settings
  clock24h = true;
  theLocale = "en_GB.UTF-8";
  theKBDLayout = "is";
  theSecondKBDLayout = "";
  theConsoleKeyMap = "is-latin1";
  theKBDVariant = "";
  theLCVariables = "is_IS.UTF-8";
  theTimezone = "Atlantic/Reykjavik";
  theShell = "zsh"; # Possible options: bash, zsh
  theKernel = "xanmod"; # Possible options: default, latest, lqx, xanmod, zen
  # For Hybrid Systems intel-nvidia
  # Should Be Used As gpuType
  cpuType = "intel"; # amd, intel, vm
  gpuType = "intel";
  laptop = false;
  boot = "gpt"; # gpt or noefi

  # Nvidia Hybrid Devices ONLY NEEDED FOR HYBRID SYSTEMS!
  intel-bus-id = "PCI:1:0:0";
  nvidia-bus-id = "PCI:0:2:0";

  # Enable / Setup NFS
  nfs = false;
  nfsMountPoint = "/mnt/nas";
  nfsDevice = "nas:/volume1/nas";

  # NTP & HWClock Settings
  ntp = true;
  localHWClock = false;

  # Enable Printer & Scanner Support
  printer = false;

  # Program Options
  browser = "floorp"; # Install & Set Default Browser
  terminal = "konsole"; # Set Default System Terminal
  distrobox = false;
  flatpak = false;
  steam = false;

  personal = false;

  # Enable Support For
  # Logitech Devices
  logitech = false;

  # Enable Terminals
  alacritty = false;
  kitty = false;

  # Enable Python & PyCharm
  python = true;

  # Enable SyncThing
  syncthing = false;
}
