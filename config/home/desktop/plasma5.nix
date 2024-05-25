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

  programs.plasma = {
    enable = true;

    panels = [
      # Windows-like panel at the bottom
      {
        location = "bottom";
        widgets = [
          "org.kde.plasma.kickoff"
          "org.kde.plasma.icontasks"
          "org.kde.plasma.marginsseperator"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
        ];
      }
    ];

    shortcuts = {
      ksmserver = {
        "Lock Session" = ["Screensaver" "Meta+L"];
      };

      kwin = {
        "Expose" = "Meta+,";
        "Switch Window Down" = "Meta+J";
        "Switch Window Left" = "Meta+H";
        "Switch Window Right" = "Meta+L";
        "Switch Window Up" = "Meta+K";
      };
    };

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
    };
  };
}
