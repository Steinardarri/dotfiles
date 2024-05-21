{
  pkgs,
  lib,
  hostname,
  ...
}: let
  inherit
    (import ../../hosts/${hostname}/options.nix)
    theKBDVariant
    theKBDLayout
    theSecondKBDLayout
    ;
in {
  services = {
    xserver = {
      enable = true;
      xkb = {
        layout = "${theKBDLayout}, ${theSecondKBDLayout}";
        variant = "${theKBDVariant}";
      };
    };

    desktopManager.plasma6 = {
      enable = lib.mkDefault true;
    };

    displayManager.sddm = {
      enable = true;
      autoNumlock = true;
      wayland.enable = true;
      settings.Wayland.SessionDir = "${pkgs.plasma5Packages.plasma-workspace}/share/wayland-sessions";
    };

    libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
      };
      touchpad = {
        # accelProfile = "flat";
        naturalScrolling = true;
        disableWhileTyping = false;
      };
    };
  };
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    oxygen
  ];

  programs = {
    wayfire = {
      enable = true;
      plugins = with pkgs.wayfirePlugins; [
        wcm
        wf-shell
        wayfire-plugins-extra
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    wayland-utils
    xwayland
    xwaylandvideobridge
    kdePackages.wayland
    kdePackages.wayqt

    clinfo
    glib
    glxinfo
    gtk3
    gtk4
    kgpg
    swt
    vulkan-tools
    wl-clipboard

    niri
    fuzzel
  ];

  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_USE_XINPUT2 = "1";
    NIXOS_OZONE_WL = "1"; # for VSCode Discord etc
  };
}
