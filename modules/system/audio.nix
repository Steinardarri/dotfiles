{
  pkgs,
  lib,
  ...
}: {
  services = {
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      pulse.enable = true;
      wireplumber.enable = true;
      jack.enable = true;
      # save some battery
      # https://www.reddit.com/r/linux/comments/1em8biv/psa_pipewire_has_been_halving_your_battery_life/
      wireplumber.extraConfig."wireplumber.profiles".main."monitor.libcamera" = "disabled";
    };
    pulseaudio.enable = lib.mkForce false;
  };

  environment.systemPackages = with pkgs; [
    easyeffects
    pipewire
    wireplumber
    pamixer
    playerctl
    pwvucontrol
  ];
}
