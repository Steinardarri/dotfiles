{...}: {
  home.persistence."/nix/persist/home" = {
    directories = [
      "NixOS_Config"
      "Desktop"
      "Documents"
      "Downloads"
      "Music"
      "Pictures"
      "Videos"
      #".cache"
      ".config/discord"
      ".continue"
      ".floorp"
      ".gnupg"
      #".local/share/sddm"
      #".local/share/kwalletd"
      ".mozilla"
      ".ssh"
      ".steam"
    ];
    files = [
      ".zsh_history"
    ];
    allowOther = true;
  };
}
