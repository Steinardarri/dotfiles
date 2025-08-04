{
  pkgs,
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

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  services.gnome.gnome-keyring.enable = true;
  programs.seahorse.enable = true;
}
