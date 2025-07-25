{username, ...}: {
  services.displayManager.sddm = {
    autoNumlock = true;
  };

  services.displayManager = {
    autoLogin.enable = true;
    autoLogin.user = "${username}";
  };
}
