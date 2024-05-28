{
  lib,
  username,
  ...
}: {
  environment.persistence."/nix/persist/system" = {
    hideMounts = true;
    directories = [
      "/etc/nixos"
      "/var/log"
      "/var/lib/bluetooth"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/etc/NetworkManager/system-connections"
    ];
    files = [
      "/etc/machine-id"
    ];
  };

  home-manager.users.${username}.home.persistence."/nix/persist/home" = {
    directories = [
      "NixOS_Config"
      "Desktop"
      "Documents"
      "Downloads"
      "Music"
      "Pictures"
      "Verkefni"
      "Videos"
      #".cache"
      ".config/discord"
      ".continue"
      ".floorp"
      ".gnupg"
      #".local/share/sddm"
      ".local/share/kwalletd"
      ".mozilla"
      ".ssh"
      ".steam"
      #".config/VSCodium"
    ];
    files = [
      ".zsh_history"
      ".gitconfig"

      # Plasma
      ".config/dolphinrc"
      ".config/konsolerc"
      ".config/systemsettingsrc"
      ".config/bluedevilglobalrc"
      ".config/gwenviewrc"
      ".config/kcalcrc"
      ".config/kpatrc"
      ".config/kritarc"
      ".config/kscreenlockerrc"
      ".config/kwinrc"
      ".config/kwriterc"
    ];
    allowOther = true;
  };

  boot.initrd.postDeviceCommands = lib.mkAfter ''
     mkdir /btrfs_tmp
     mount /dev/root_vg/root /btrfs_tmp
     if [[ -e /btrfs_tmp/root ]]; then
         mkdir -p /btrfs_tmp/old_roots
         timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/root)" "+%Y-%m-%-d_%H:%M:%S")
         mv /btrfs_tmp/root "/btrfs_tmp/old_roots/$timestamp"
     fi
    delete_subvolume_recursively() {
         IFS=$'\n'
         for i in $(btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
             delete_subvolume_recursively "/btrfs_tmp/$i"
         done
         btrfs subvolume delete "$1"
     }
    for i in $(find /btrfs_tmp/old_roots/ -maxdepth 1 -mtime +30); do
         delete_subvolume_recursively "$i"
     done
    btrfs subvolume create /btrfs_tmp/root
     umount /btrfs_tmp
  '';

  programs.fuse.userAllowOther = true;
}
