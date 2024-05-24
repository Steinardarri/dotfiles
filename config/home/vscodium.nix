{
  pkgs,
  username,
  ...
}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;
    mutableExtensionsDir = false;

    extensions = with pkgs.vscode-extensions; [
      alefragnani.bookmarks
      christian-kohler.path-intellisense
      continue.continue
      eamodio.gitlens
      jnoortheen.nix-ide
      kamadorueda.alejandra
      mhutchie.git-graph
      seatonjiang.gitmoji-vscode
      vscode-icons-team.vscode-icons
    ];

    userSettings = {
      # General
      "editor.fontSize" = 16;
      "editor.fontFamily" = "'Hack NF FC Ligatured CCG'; 'Hack'; 'monospace'; monospace";
      "editor.fontLigatures" = true;
      "terminal.integrated.fontSize" = 14;
      "terminal.integrated.fontFamily" = "'Hack NF FC Ligatured CCG'; 'FiraCode Nerd Font'; 'monospace'; monospace";
      "window.zoomLevel" = 1;
      "workbench.startupEditor" = "none";
      "explorer.compactFolders" = false;

      # Editor
      "editor.guides.bracketPairs" = "active";
      "editor.tabSize" = 2;
      "editor.tabCompletion" = "onlySnippets";
      "editor.quickSuggestions.strings" = "on";
      "files.autoSave" = "afterDelay";
      "editor.formatOnSave" = true;
      "editor.formatOnPaste" = true;
      "editor.wordWrap" = "bounded";
      "editor.wrappingIndent" = "deepIndent";

      # Whitespace
      "files.trimTrailingWhitespace" = true;
      "files.trimFinalNewlines" = true;
      "files.insertFinalNewline" = true;
      "diffEditor.ignoreTrimWhitespace" = false;

      # Terminal
      "terminal.integrated.cursorBlinking" = true;
      "terminal.integrated.cursorStyle" = "line";
      "terminal.integrated.cursorWidth" = 2;
      "terminal.integrated.enableImages" = true;

      # Git
      "git.autofetch" = true;
      "git.enableSmartCommit" = true;
      "git.confirmSync" = false;
      "git.enableCommitSigning" = true;
      "git-graph.repository.sign.commits" = true;
      "git-graph.repository.sign.tags" = true;
      "git-graph.repository.commits.showSignatureStatus" = true;
      "git.allowForcePush" = true;
      "git.defaultBranchName" = "master";
      "git.defaultCloneDirectory" = "~/Verkefni";
      "git.openAfterClone" = "alwaysNewWindow";
      "git.pruneOnFetch" = true;
      "git.fetchOnPull" = true;
      "git.pullBeforeCheckout" = true;
      "git.rebaseWhenSync" = true;

      # Styling
      "editor.bracketPairColorization.independentColorPoolPerBracketType" = true;
      "workbench.colorCustomizations.editorInlayHint.typeBackground" = "#2F3542";
      "editor.semanticTokenColorCustomizations.enabled" = true;
      # Stylix handles the rest

      # Other
      "telemetry.telemetryLevel" = "off";
      "update.showReleaseNotes" = false;

      ## Extensions ##

      "workbench.iconTheme" = "vscode-icons";
      "continue.enableTabAutocomplete" = true;

      # Nix
      "alejandra.program" = "alejandra";
      "nix.enableLanguageServer" = true;
      "[nix]" = {
        "editor.defaultFormatter" = "kamadorueda.alejandra";
        "editor.formatOnPaste" = true;
        "editor.formatOnSave" = true;
        "editor.formatOnType" = false;
      };
      # GitLens
      "gitlens.currentLine.enabled" = false;
      "gitlens.codeLens.enabled" = false;
      "gitlens.hovers.enabled" = false;
      "gitlens.showWelcomeOnInstall" = false;
      "gitlens.plusFeatures.enabled" = false;

      # Gitmoji
      "gitmoji.onlyUseCustomEmoji" = true;
      "gitmoji.addCustomEmoji" = [
        {
          "emoji" = "📦 NEW:";
          "code" = ":package: NEW:";
          "description" = "... Add new code/feature";
        }
        {
          "emoji" = "👌 IMPROVE:";
          "code" = ":ok_hand: IMPROVE:";
          "description" = "... Improve existing code/feature";
        }
        {
          "emoji" = "❌ REMOVE:";
          "code" = ":x: REMOVE:";
          "description" = "... Remove existing code/feature";
        }
        {
          "emoji" = "🐛 FIX:";
          "code" = ":bug: FIX:";
          "description" = "... Fix a bug";
        }
        {
          "emoji" = "📑 DOC:";
          "code" = ":bookmark_tabs: DOC:";
          "description" = "... Anything related to documentation";
        }
        {
          "emoji" = "🤖 TEST:";
          "code" = ":robot: TEST:";
          "description" = "... Anything realted to tests";
        }
      ];
    };

    keybindings = [
      {
        "key" = "ctrl+shift+numpad_divide";
        "command" = "editor.action.blockComment";
        "when" = "editorTextFocus && !editorReadonly";
      }
      {
        "key" = "shift+alt+a";
        "command" = "-editor.action.blockComment";
        "when" = "editorTextFocus && !editorReadonly";
      }
      {
        "key" = "ctrl+numpad_divide";
        "command" = "editor.action.commentLine";
        "when" = "editorTextFocus && !editorReadonly";
      }
      {
        "key" = "ctrl+oem_2";
        "command" = "-editor.action.commentLine";
        "when" = "editorTextFocus && !editorReadonly";
      }
    ];
  };

  environment.persistence."/persist".users.${username}.directories = [".config/VSCodium"];
}
