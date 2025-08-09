{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.hyprland.nixosModules.default

    ./gaming.nix
    ./nano.nix
    ./thunar.nix
  ];

  programs = {
    # https://wiki.hypr.land/Nix/Hyprland-on-NixOS/
    hyprland = let
      hypr-pkgs = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
    in {
      enable = true;
      withUWSM = true;
      package = hypr-pkgs.hyprland;
      portalPackage = hypr-pkgs.xdg-desktop-portal-hyprland;
      # Disable XWayland when Steam finally gets a 64 bit wayland client
      xwayland.enable = true;
      systemd.setPath.enable = true;
    };
    dconf.enable = true;
    nix-ld.enable = true;
    partition-manager.enable = true;
    direnv = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
    };
  };
}
