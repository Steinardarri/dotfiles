{inputs, ...}: {
  imports = [
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];
  home.persistence."/persist/home" = {
    directories = [
      "NixOS_Config"
      "Desktop"
      "Documents"
      "Downloads"
      "Forrit"
      "Music"
      "Pictures"
      "Verkefni"
      "Videos"
      ".config/discord"
      ".continue"
      ".floorp"
      ".mozilla"
      {
        directory = ".gnupg";
        mode = "0700";
      }
      {
        directory = ".ssh";
        mode = "0700";
      }
      {
        directory = ".local/share/Steam";
        method = "symlink";
      }

      # Plasma
      {
        directory = ".local/share/kwalletd";
        mode = "0700";
      }
      ".local/share/kdenlive"
      ".local/share/konsole"
      ".local/share/krita"
      ".local/share/ktorrent"
      ".local/share/kwrite"
      ".local/share/arianna"
    ];
    files = [
      ".zsh_history"
      ".gitconfig"

      # Plasma
      # ".config/dolphinrc"
      # ".config/konsolerc"
      # ".config/systemsettingsrc"
      # ".config/bluedevilglobalrc"
      # ".config/gwenviewrc"
      # ".config/kcalcrc"
      # ".config/kpatrc"
      # ".config/kritarc"
      # ".config/kscreenlockerrc"
      # ".config/kwinrc"
      # ".config/kwriterc"
    ];
    allowOther = true;
  };
}
