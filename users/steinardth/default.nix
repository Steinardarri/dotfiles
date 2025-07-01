{
  pkgs,
  username,
  hostname,
  ...
}: let
  inherit (import ../hosts/${hostname}/options.nix) gitUsername theShell;
in {
  # You can create your own hashedPassword with 'mkpasswd'
  # Needed when mutableUsers is false
  users = {
    users."${username}" = {
      isNormalUser = true;
      homeMode = "755";
      hashedPassword = "$6$QzM71suXeaEOJclY$yClL4QHPI6h88qWhIqPZWG.5HJ2YS8maq1HA1UMYoUC6OeUQpMjFgVtI.wbci/V49x0wK0wHxcpN3vwpZONjV/";
      description = "${gitUsername}";
      extraGroups = ["networkmanager" "wheel"];
      shell = pkgs.${theShell};
      ignoreShellProgramCheck = true;
    };
    mutableUsers = false;
  };

  # Whether you need to input password on sudo
  security.sudo.wheelNeedsPassword = false;

  imports = [
    # System Modules and others
    ../../modules/system/desktop/hyprland
    # ../../modules/stylix
    ../../modules/system/services/flatpak.nix
    ../../modules/system/services/jellyfin.nix
    ../../modules/system/gaming.nix
    ../../modules/system/python.nix
    ../../modules/system/programs/nano.nix
  ];

  programs = {
    kdeconnect.enable = true;
    partition-manager.enable = true;
  };
}
