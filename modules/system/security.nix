{
  pkgs,
  lib,
  ...
}: {
  security = {
    sudo-rs = {
      enable = true;
      execWheelOnly = true;
    };
    protectKernelImage = true;

    # Realtime stuff for PipeWire, PulseAudio
    rtkit.enable = true;
  };

  environment.systemPackages = with pkgs; [
    gnupg
    pinentry-gnome3
  ];
  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
  environment.variables = {
    PINENTRY = "pinentry-gnome3";
    SSH_ASKPASS_REQUIRE = "prefer";
  };
}
