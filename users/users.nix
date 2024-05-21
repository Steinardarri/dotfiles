{
  pkgs,
  config,
  username,
  hostname,
  ...
}: let
  inherit (import ./../hosts/${hostname}/options.nix) gitUsername theShell;
in {
  users.users = {
    "${username}" = {
      homeMode = "755";
      isNormalUser = true;
      description = "${gitUsername}";
      extraGroups = ["networkmanager" "wheel" "libvirtd"];
      shell = pkgs.${theShell};
      ignoreShellProgramCheck = true;
    };
  };
}
