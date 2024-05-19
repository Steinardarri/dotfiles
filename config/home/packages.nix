{
  pkgs,
  config,
  username,
  hostname,
  ...
}: let
  inherit
    (import ../../hosts/${hostname}/options.nix)
    browser
    wallpaperDir
    wallpaperGit
    flakeDir
    ;
in {
  # Install Packages For The User
  home.packages = with pkgs; [
    pkgs."${browser}"
    discord
    libvirt
    swww
    grim
    slurp
    gnome.file-roller
    swaynotificationcenter
    rofi-wayland
    imv
    gimp
    rustup
    pavucontrol
    tree
    protonup-qt
    mpv
    font-awesome
    spotify
    swayidle
    neovide
    swaylock
    (nerdfonts.override {fonts = ["Hack" "JetBrainsMono"];})
    # Import Scripts
    (import ./../scripts/emopicker9000.nix {inherit pkgs;})
    (import ./../scripts/task-waybar.nix {inherit pkgs;})
    (import ./../scripts/squirtle.nix {inherit pkgs;})
    (import ./../scripts/wallsetter.nix {
      inherit pkgs;
      inherit wallpaperDir;
      inherit username;
      inherit wallpaperGit;
    })
    (import ./../scripts/themechange.nix {
      inherit pkgs;
      inherit flakeDir;
      inherit host;
    })
    (import ./../scripts/theme-selector.nix {inherit pkgs;})
    (import ./../scripts/nvidia-offload.nix {inherit pkgs;})
    (import ./../scripts/web-search.nix {inherit pkgs;})
    (import ./../scripts/rofi-launcher.nix {inherit pkgs;})
    (import ./../scripts/screenshootin.nix {inherit pkgs;})
    (import ./../scripts/list-hypr-bindings.nix {
      inherit pkgs;
      inherit host;
    })
  ];

  programs.gh.enable = true;
}
