{
  lib,
  config,
  ...
}: {
  options = {
    _lact.enable = lib.mkEnableOption "User-Defined LACT Module";
  };

  config = lib.mkIf config._lact.enable {
    services.lact.enable = true;
  };
}
