{pkgs, ...}: {
  imports = [
    ./equibop

    ./torrent.nix
  ];

  programs = {
    partition-manager.enable = true;
  };

  environment.systemPackages = with pkgs; [
    ungoogled-chromium
  ];
}
