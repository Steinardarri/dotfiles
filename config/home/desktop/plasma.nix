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

      kwin.virtualDesktops = {
        animation = "slide";
        number = 3;
      };

      panels = [
        # Windows-like panel at the bottom
        {
          location = "bottom";
          widgets = [
            {
              name = "org.kde.plasma.kickoff";
              config = {
                General.icon = "nix-snowflake-white";
              };
            }
            {
              name = "org.kde.plasma.icontasks";
              config = {
                General.launchers = [
                  "applications:org.kde.dolphin.desktop"
                  "applications:org.kde.konsole.desktop"
                ];
              };
            }
            "org.kde.plasma.marginsseperator"
            "org.kde.plasma.systemtray"
            {
              digitalClock = {
                calendar.firstDayOfWeek = "monday";
                time.format = "24h";
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
        };
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

        "kwinrc"."Compositing"."LatencyPolicy" = "low";
        "kdeglobals"."KDE"."AnimationDurationFactor" = 0;

        # Patch fix for cursor issues
        # Stylix should handle this
        # "icons"."default"."index.theme" = ''
        #   [Icon Theme]
        #   Inherits=breeze_cursors
        # '';

        kscreenlockerrc = {
          Greeter.WallpaperPlugin = "org.kde.potd";
          "Greeter/Wallpaper/org.kde.potd/General".Provider = "simonstalenhag";
        };
      };
    };

    konsole = {
      enable = true;
      defaultProfile = "Minn";

      profiles."Minn" = {
        colorScheme = "DarkPastels";
        font = {
          name = "Hack Nerd Font";
          size = 14;
        };
        extraConfig = {
          "[Appearance]" = {
            dimmValue = 10;
          };
          "[Cursor Options]" = {
            cursorShape = 1;
          };
          "[General]" = {
            dimWhenInactive = true;
            icon = "emblem-favorite";
          };
          "[Interaction Options]" = {
            autoCopySelectedText = true;
            middleClickPasteMode = 1;
            openLinksByDirectClickEnabled = true;
            textEditorCmd = 6;
            trimLeadingSpacesInSelectedText = true;
            trimTrailingSpacesInSelectedText = true;
            underlineFilesEnabled = true;
          };
          "[Scrolling]" = {
            historySize = 10000;
          };
          "[Terminal Features]" = {
            blinkingCursorEnabled = true;
          };
        };
      };
    };
  };
}
