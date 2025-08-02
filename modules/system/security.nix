{
  lib,
  pkgs,
  ...
}: {
  security = {
    sudo-rs = {
      enable = true;
      execWheelOnly = true;
    };
    protectKernelImage = true;

    # Realtime stuff for PipeWire, PulsAudio
    rtkit.enable = true;

    # Not working
    # pam.services.kwallet = {
    #   enable = true;
    #   kwallet.enable = true;
    # };
  };

  environment.systemPackages = with pkgs; [
    kdePackages.kleopatra
    kdePackages.kwallet
    kdePackages.kwalletmanager
    kdePackages.ksshaskpass
    pinentry-qt
    gnupg
  ];
  environment.variables = {
    PINENTRY = "pinentry-qt";
    SSH_ASKPASS = lib.mkForce "/run/current-system/sw/bin/ksshaskpass";
    SSH_ASKPASS_REQUIRE = "prefer";
  };
}
