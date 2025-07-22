{pkgs, ...}: {
  imports = [
    ./equibop
  ];

  programs = {
    partition-manager.enable = true;
  };

  environment.systemPackages = with pkgs; [
    ungoogled-chromium
  ];
}
