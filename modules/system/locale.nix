{pkgs, ...}: {
  i18n = {
    defaultLocale = "en_GB.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "is_IS.UTF-8";
      LC_COLLATE = "is_IS.UTF-8";
      LC_CTYPE = "en_GB.UTF-8";
      LC_IDENTIFICATION = "is_IS.UTF-8";
      LC_MEASUREMENT = "is_IS.UTF-8";
      LC_MESSAGES = "en_US.UTF-8";
      LC_MONETARY = "is_IS.UTF-8";
      LC_NAME = "is_IS.UTF-8";
      LC_NUMERIC = "is_IS.UTF-8";
      LC_PAPER = "is_IS.UTF-8";
      LC_TELEPHONE = "is_IS.UTF-8";
      LC_TIME = "is_IS.UTF-8";
    };
  };

  console = {
    keyMap = "is-latin1";
    # Font that supports all latin fonts better
    font = "Lat2-Terminus16";
    packages = [pkgs.terminus_font];
  };

  environment.variables = {
    LANG = "en_GB.UTF-8";
  };
}
