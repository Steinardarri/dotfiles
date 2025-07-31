{
  inputs,
  pkgs,
  ...
}: {
  home.packages = [
    inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default.override
    (oldAttrs: {
      withX11 = false;
      withI3 = false;
    })
  ];
}
