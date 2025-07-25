{pkgs, ...}: {
  imports = [
    ./equibop

    ./gaming.nix
    ./nano.nix
    ./torrent.nix
  ];

  programs = {
    partition-manager.enable = true;
  };

  environment.systemPackages = with pkgs; [
    ungoogled-chromium
  ];
}
