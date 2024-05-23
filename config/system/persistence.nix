{username, ...}: {
  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
    ];
    files = [
      # "/etc/machine-id"
    ];
    users.${username} = {
      directories = [
        "NixOS_Config"
        "Desktop"
        "Documents"
        "Downloads"
        "Music"
        "Pictures"
        "Videos"
        ".cache"
        ".config/discord"
        ".continue"
        ".floorp"
        ".local/share/sddm"
        ".mozilla"
        ".ssh"
        ".steam"
        ".vscode-oss"
      ];
      files = [
        ".zsh_history"
      ];
    };
  };
}
