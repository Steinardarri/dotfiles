{pkgs, ...}: {
  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      wireplumber = {
        enable = true;
        # save some battery
        # https://www.reddit.com/r/linux/comments/1em8biv/psa_pipewire_has_been_halving_your_battery_life/
        extraConfig."wireplumber.profiles".main."monitor.libcamera" = "disabled";
      };
      jack.enable = false;
    };
  };
  services.pulseaudio.enable = false;

  environment.systemPackages = with pkgs; [
    easyeffects
    pamixer
    playerctl
    pwvucontrol
  ];
}
