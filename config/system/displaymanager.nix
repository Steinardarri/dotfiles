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

    desktopManager.plasma6.enable = lib.mkDefault true;

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

    niri
    fuzzel
  ];

  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    NIXOS_OZONE_WL = "1"; # for VSCode Discord etc
  };
}
