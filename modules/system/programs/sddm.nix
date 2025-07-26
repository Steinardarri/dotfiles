{
  pkgs,
  username,
  ...
}: {
  services.displayManager = {
    autoLogin.enable = true;
    autoLogin.user = "${username}";

    sddm = {
      enable = true;
      wayland.enable = true;
      autoNumlock = true;
      extraPackages = with pkgs; [
        kdePackages.sddm-kcm
        kdePackages.qtsvg
        kdePackages.qtmultimedia
        kdePackages.qtvirtualkeyboard
        kdePackages.qtquickcontrols2
        kdePackages.qtgraphicaleffects
        kdePackages.layer-shell-qt
        kdePackages.qtwayland
      ];
      settings = {
        General = {
          # Set default session globally
          DefaultSession = "hyprland.desktop";
        };
        Wayland = {
          EnableHiDPI = true;
        };
      };
    };
  };
}
