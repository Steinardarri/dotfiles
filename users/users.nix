{
  pkgs,
  username,
  hostname,
  ...
}: let
  inherit (import ./../hosts/${hostname}/options.nix) gitUsername theShell;
in {
  users.users = {
    "${username}" = {
      isNormalUser = true;
      homeMode = "755";
      description = "${gitUsername}";
      extraGroups = ["networkmanager" "wheel"];
      shell = pkgs.${theShell};
      ignoreShellProgramCheck = true;
    };
  };
}
