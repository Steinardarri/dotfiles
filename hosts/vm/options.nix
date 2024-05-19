# PLEASE READ THE WIKI FOR DETERMINING
# WHAT TO PUT HERE AS OPTIONS.
# https://gitlab.com/Zaney/zaneyos/-/wikis/Setting-Options
let
  setUsername = "steinardth";
  setHostname = "vm";
in {
  # No Change Needed Below
  username = "${setUsername}";
  hostname = "${setHostname}";
  userHome = "/home/${setUsername}";
  flakeDir = "/home/${setUsername}/.config/NixOS_Config";
  wallpaperGit = "https://gitlab.com/Zaney/my-wallpapers.git"; # Can be changed IF you know what your doing
  wallpaperDir = "/home/${setUsername}/Pictures/Wallpapers";
  screenshotDir = "/home/${setUsername}/Pictures/Screenshots";
  flakePrev = "/home/${setUsername}/.backup/NixOS_Config-previous";
  flakeBackup = "/home/${setUsername}/.backup/NixOS_Config-backup";

  # Git Configuration ( For Pulling Software Repos )
  gitUsername = "Steinar Darri Þorgilsson";
  gitEmail = "steinar@steinardth.xyz";

  # Base16 Theme
  theme = "nord";

  # Hyprland Settings
  borderAnim = true; # Enable / Disable Hyprland Border Animation
  extraMonitorSettings = "";

  # Waybar Settings
  waybarAnim = true; # Enable / Disable Waybar Animation CSS
  bar-number = true; # Enable / Disable Workspace Numbers In Waybar

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
  theKernel = "zen"; # Possible options: default, latest, lqx, xanmod, zen
  sdl-videodriver = "wayland"; # Either x11 or wayland ONLY. Games might require x11 set here
  # For Hybrid Systems intel-nvidia
  # Should Be Used As gpuType
  cpuType = "vm"; # amd, intel, vm
  gpuType = "amd";
  laptop = false;
  boot = "noefi"; # gpt or noefi

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
  terminal = "kitty"; # Set Default System Terminal
  distrobox = false;
  flatpak = false;
  kdenlive = false;
  blender = false;
  enableZeroAD = false;
  steam = false;

  # Enable Support For
  # Logitech Devices
  logitech = false;

  # Enable Terminals ( If You Disable All You Get Kitty )
  wezterm = false;
  alacritty = false;
  kitty = true;

  # Enable Python & PyCharm
  python = false;

  # Enable SyncThing
  syncthing = false;
}
