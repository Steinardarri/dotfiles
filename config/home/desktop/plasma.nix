{
  hostname,
  inputs,
  ...
}: let
  inherit
    (import ../../../hosts/${hostname}/options.nix)
    theLocale
    theLCVariables
    browser
    terminal
    ;
in {
  imports = [
    inputs.plasma-manager.homeManagerModules.plasma-manager
  ];

  programs = {
    plasma = {
      enable = true;

      # Nuke the Plasma Configs
      # https://github.com/pjones/plasma-manager/blob/trunk/modules/files.nix#L29
      # Persistence will do this also, of course, if the files aren't protected
      overrideConfig = false;

      workspace = {
        # Theme, Wallpaper, Fonts & Cursor is managed by Stylix
        clickItemTo = "select";
      };

      kwin = {
        effects.shakeCursor.enable = true;
        titlebarButtons.right = ["help" "minimize" "maximize" "close"];
        titlebarButtons.left = ["on-all-desktops" "keep-above-windows"];
        virtualDesktops = {
          animation = "slide";
          number = 4;
          rows = 2;
        };
      };

      panels = [
        # Windows-like panel at the bottom of main screen
        {
          screen = 0;
          location = "bottom";
          height = 38;
          floating = true;
          hiding = "dodgewindows";
          widgets = [
            {
              name = "org.kde.plasma.kickoff";
              config = {
                General.icon = "nix-snowflake";
              };
            }
            {
              name = "org.kde.plasma.pager";
            }
            {
              name = "org.kde.plasma.icontasks";
              config = {
                General.launchers = [
                  "applications:systemsettings.desktop"
                  "applications:org.kde.dolphin.desktop"
                  "applications:org.kde.konsole.desktop"
                  "applications:floorp.desktop"
                  "applications:codium.desktop"
                  "applications:steam.desktop"
                ];
                General.showOnlyCurrentScreen = "true";
              };
            }
            "org.kde.plasma.marginsseperator"
            "org.kde.plasma.systemtray"
            {
              digitalClock = {
                calendar.firstDayOfWeek = "monday";
                time.format = "24h";
                date.format = "isoDate";
              };
            }
            "org.kde.plasma.showdesktop"
          ];
        }
        {
          screen = 1;
          location = "right";
          height = 38;
          floating = true;
          hiding = "dodgewindows";
          widgets = [
            {
              name = "org.kde.plasma.icontasks";
              config = {
                General.launchers = [
                  "applications:discord.desktop"
                ];
                General.showOnlyCurrentScreen = "true";
              };
            }
            "org.kde.plasma.marginsseperator"
            "org.kde.plasma.notifications"
            "org.kde.plasma.systemtray"
            {
              digitalClock = {
                calendar.firstDayOfWeek = "monday";
                time.format = "24h";
                date.enable = false;
              };
            }
            "org.kde.plasma.showdesktop"
          ];
        }
        {
          screen = 2;
          location = "left";
          height = 38;
          floating = true;
          hiding = "dodgewindows";
          widgets = [
            {
              name = "org.kde.plasma.icontasks";
              config = {
                General.showOnlyCurrentScreen = "true";
              };
            }
            "org.kde.plasma.marginsseperator"
            "org.kde.plasma.systemtray"
            {
              digitalClock = {
                calendar.firstDayOfWeek = "monday";
                time.format = "24h";
                date.enable = false;
              };
            }
            "org.kde.plasma.showdesktop"
          ];
        }
      ];

      windows.allowWindowsToRememberPositions = true;

      # Hotkeys
      hotkeys.commands = {
        "terminal" = {
          name = "Launch Terminal";
          key = "Ctrl+Alt+T";
          command = "${terminal}";
        };
        "browser" = {
          name = "Launch Internet Browser";
          key = "Ctrl+Alt+C";
          command = "${browser}";
        };
        "filebrowser" = {
          name = "Launch File Browser";
          key = "Ctrl+Alt+F";
          command = "dolphin";
        };
        "notepad" = {
          name = "Launch a Notepad";
          key = "Ctrl+Alt+N";
          command = "kwrite";
        };
      };

      shortcuts = {
        ksmserver = {
          "Lock Session" = ["Screensaver" "Meta+L"];
        };

        kwin = {
          "Expose" = "Meta+,";
          "Walk Through Windows of Current Application" = "Alt+<";
          "Walk Through Windows of Current Application (Reverse)" = "Alt+>";
          "Window Maximize" = "Meta+Up";
          "Window Minimize" = "Meta+Down";
          "Window Quick Tile Bottom" = [];
          "Window Quick Tile Top" = [];
          "view_zoom_in" = [];
          "view_zoom_out" = [];
        };

        "kaccess"."Toggle Screen Reader On and Off" = [];
      };

      # Misc Custom Configs
      configFile = {
        "plasma-localerc"."Formats"."LANG" = "${theLocale}";
        "plasma-localerc"."Formats"."LC_ADDRESS" = "${theLCVariables}";
        "plasma-localerc"."Formats"."LC_IDENTIFICATION" = "${theLCVariables}";
        "plasma-localerc"."Formats"."LC_MEASUREMENT" = "${theLCVariables}";
        "plasma-localerc"."Formats"."LC_MONETARY" = "${theLCVariables}";
        "plasma-localerc"."Formats"."LC_NAME" = "${theLCVariables}";
        "plasma-localerc"."Formats"."LC_NUMERIC" = "${theLCVariables}";
        "plasma-localerc"."Formats"."LC_PAPER" = "${theLCVariables}";
        "plasma-localerc"."Formats"."LC_TELEPHONE" = "${theLCVariables}";
        "plasma-localerc"."Formats"."LC_TIME" = "${theLCVariables}";

        "kcminputrc"."Libinput/1133/16511/Logitech G502"."PointerAccelerationProfile" = 1;
        "kcminputrc"."Libinput/1133/49293/Logitech G502 LIGHTSPEED Wireless Gaming Mouse"."PointerAccelerationProfile" = 1;

        "kdeglobals"."General"."AllowKDEAppsToRememberWindowPositions" = true;
        "kwinrc"."Compositing"."LatencyPolicy" = "low";
        "kdeglobals"."KDE"."AnimationDurationFactor" = 0.17677669529663687;
        "kwinrc"."Effect-overview"."BorderActivate" = 9;
        "kwinrc"."Effect-translucency"."ComboboxPopups" = 90;
        "kwinrc"."Effect-translucency"."Dialogs" = 90;
        "kwinrc"."Plugins"."blurEnabled" = true;
        "kwinrc"."Plugins"."fadedesktopEnabled" = false;
        "kwinrc"."Plugins"."sheetEnabled" = true;
        "kwinrc"."Plugins"."slideEnabled" = true;
        "kwinrc"."Plugins"."zoomEnabled" = false;
        "kwinrc"."Tiling"."padding" = 4;
        "kwinrc"."Xwayland"."Scale" = 1;

        "kwalletrc"."Wallet"."First Use" = false;

        kscreenlockerrc = {
          Greeter.WallpaperPlugin = "org.kde.potd";
          "Greeter/Wallpaper/org.kde.potd/General".Provider = "simonstalenhag";
        };
      };
    };

    konsole = {
      enable = true;
      # defaultProfile = "Minn";

      # profiles."Minn" = {
      #   colorScheme = "DarkPastels";
      #   font = {
      #     name = "Hack Nerd Font";
      #     size = 14;
      #   };
      #   extraConfig = {
      #     # "Appearance" = {
      #     #   emojiFont = "";
      #     # };
      #     "Cursor Options" = {
      #       cursorShape = 1;
      #     };
      #     "General" = {
      #       icon = "emblem-favorite";
      #     };
      #     "Interaction Options" = {
      #       autoCopySelectedText = true;
      #       middleClickPasteMode = 1;
      #       openLinksByDirectClickEnabled = true;
      #       textEditorCmd = 6;
      #       trimLeadingSpacesInSelectedText = true;
      #       trimTrailingSpacesInSelectedText = true;
      #       underlineFilesEnabled = true;
      #     };
      #     "Scrolling" = {
      #       historySize = 10000;
      #     };
      #     "Terminal Features" = {
      #       blinkingCursorEnabled = true;
      #     };
      #   };
      # };
    };
  };

  # Custom Nix Splash
  home.file.".local/share/plasma/look-and-feel" = {
    source = ./nixsimpleblue;
    recursive = true;
  };
}
