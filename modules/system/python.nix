{pkgs, ...}: let
  my-python-packages = ps:
    with ps; [
      numpy
      pandas
      requests
    ];
in {
  environment.systemPackages = with pkgs; [
    (pkgs.python3.withPackages my-python-packages)
    ruff
    black
  ];
}
