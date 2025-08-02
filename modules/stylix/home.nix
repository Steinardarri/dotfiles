{stylixTheme, ...}: {
  imports = [
    ./${stylixTheme}/home.nix
  ];

  stylix = {
    enable = true;
    autoEnable = true;

    targets.zen-browser.profileNames = ["default"];
  };
}
