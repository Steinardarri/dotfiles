{pkgs, ...}: {
  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      wireplumber.enable = true;
    };
    blueman.enable = true;
  };

  environment.systemPackages = with pkgs; [
    bluez
    bluez-tools
    blueman
    easyeffects
    pipewire
    wireplumber
    pamixer
    playerctl
    lxqt.pavucontrol-qt
    pulseaudioFull
  ];
}
