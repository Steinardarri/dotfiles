{pkgs, ...}: {
  imports = [
    ./files
    ./shell
  ];

  home.packages = with pkgs; [
    lapce
    gimp3-with-plugins
    element-desktop
    
    kdePackages.krita
    kdePackages.qalculate
  ];
}
