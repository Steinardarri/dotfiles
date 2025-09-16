{
  pkgs,
  lib,
  ...
}: {
  users.users.root.shell = pkgs.zsh;

  programs = {
    fish = {
      enable = true;
      useBabelfish = true;
    };
    # Zsh used as the login shell, to launch hyprland and switch over to fish
    # https://nixos.wiki/wiki/Fish#Setting_fish_as_your_shell
    zsh = {
      enable = true;
      loginShellInit = ''
        if uwsm check may-start; then
          exec uwsm start hyprland-uwsm.desktop
        fi
      '';
      interactiveShellInit = lib.mkBefore ''
        if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z $ZSH_EXECUTION_STRING ]]
        then
          if [[ -o login ]]; then LOGIN_OPTION='--login'; else LOGIN_OPTION=""; fi
          exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
        fi
      '';
    };
  };

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";
      ECORE_EVAS_ENGINE = "wayland_egl";
      ELM_ENGINE = "wayland_egl";
      PAGER = "bat";
      WLR_NO_HARDWARE_CURSORS = "1";
    };

    pathsToLink = [
      "/share/icons"
      "/share/themes"
      "/share/fonts"
      "/share/xdg-desktop-portal"
      "/share/applications"
      "/share/mime"
      "/share/wayland-sessions"
      "/share/zsh"
      "/share/bash-completion"
      "/share/fish"
    ];
  };

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

  # Regist appimage-run as the executor of appimages
  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };
}
