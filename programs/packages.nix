# Imported in /hosts/default.nix

{pkgs, ...}: with pkgs; [
  # GUI
  firefox
  vscode
  alacritty
  gimp

  # Programming
  rustup
  nodejs

  # Archives
  ark
  unrar
  unzip
  atool
  zip
  p7zip

  # Utils
  git
  wget
  just
  curl
  gparted
  barrier
  file
  ffmpeg
  asciinema
  neofetch
]