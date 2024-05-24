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
      hashedPassword = "$y$j9T$ICLGmfVT2bdP62Xb8dK.F/$AWvH.3MIzBN/HeHfk31kPOZ5J60f6xq5U8WiAwwOH/D";
      description = "${gitUsername}";
      extraGroups = ["networkmanager" "wheel"];
      shell = pkgs.${theShell};
      ignoreShellProgramCheck = true;
      openssh.authorizedKeys = {
      };
    };
    mutableUsers = false;
  };
}
