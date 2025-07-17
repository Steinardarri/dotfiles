let
  setUsername = "steinardth";
  setHostname = "heima";
in {
  ## System ##
  # Base definitions
  username = "${setUsername}";
  hostname = "${setHostname}";
  system = "x86_64-linux";
  userHome = "/home/${setUsername}";
  flakeDir = "/home/${setUsername}/dotfiles";

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
  theShell = "fish"; # fish, zsh, bash
  theKernel = "xanmod"; # default, latest, lqx, xanmod, zen

  ## Hardware ##
  # Designation of device to install NixOS on
  device = "/dev/nvme1n1";

  # For Hybrid Systems 'intel-nvidia' should Be Used As gpuType
  cpuType = "amd"; # amd, intel, vm
  gpuType = "amd"; # amd, intel, nvidia, intel-nvidia
  laptop = false;
  boot = "disko"; # grub variants: default, disko or noefi

  logitech = true;

  # Enable Printer & Scanner Support
  printer = false;

  ## Programs
  # Clock Settings
  ntp = true; # Network
  localHWClock = false;
}
