{
  pkgs,
  lib,
  ...
}: {
  hydenix.hm.editors = {
    enable = true;
    neovim = false;
    vscode = {
      enable = false; # Overriden below
      wallbash = true; # enable wallbash extension for vscode
    };
    vim = false;
    default = "codium";
  };

  # VSCode -> VSCodium overrides
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    mutableExtensionsDir = false;

    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;

      extensions =
        with pkgs.nix-vscode-extensions.open-vsx; [
          # https://raw.githubusercontent.com/nix-community/nix-vscode-extensions/master/data/cache/open-vsx-latest.json

          # Editor
          kylinideteam.gitlens # Gitlens lower version for friendly license
          mhutchie.git-graph
          usernamehw.errorlens
          jellydn.toggle-excluded-files

          # Aesthetics
          gaplo917.gapstylevs
          esbenp.prettier-vscode
          jock.svg
          naumovs.color-highlight
          seatonjiang.gitmoji-vscode
          pkief.material-icon-theme
          pkief.material-product-icons
          delgan.qml-format

          # Toolset
          christian-kohler.path-intellisense
          formulahendry.code-runner
          wix.vscode-import-cost
          firefox-devtools.vscode-firefox-debug
          fill-labs.dependi
          semanticdiff.semanticdiff

          # AI
          continue.continue

          # Language specific
          jnoortheen.nix-ide
          james-yu.latex-workshop
          tamasfe.even-better-toml
          yzhang.markdown-all-in-one
          ewen-lbh.vscode-hyprls
          detachhead.basedpyright
          bmalehorn.vscode-fish
          ndonfris.fish-lsp
          cutetee.qml
          charliermarsh.ruff
          rust-lang.rust-analyzer
          timonwong.shellcheck
          svelte.svelte-vscode

          # Workflow
          alefragnani.bookmarks
          gruntfuggly.todo-tree
        ]
        # ++ (with pkgs.nix-vscode-extensions.vscode-marketplace; [
        #   # https://raw.githubusercontent.com/nix-community/nix-vscode-extensions/master/data/cache/vscode-marketplace-latest.json
        # ])
        ;

      userSettings = {
        # General
        "editor.fontSize" = lib.mkDefault 16;
        "editor.fontFamily" = "'monospace', monospace";
        "editor.fontLigatures" = true;
        "terminal.integrated.fontSize" = lib.mkDefault 14;
        "window.zoomLevel" = 1;
        "workbench.startupEditor" = "none";
        "explorer.compactFolders" = false;
        "workbench.enableExperiments" = false;
        "workbench.cloudChanges.autoResume" = "off";
        "workbench.cloudChanges.continueOn" = "off";

        # Security
        "security.workspace.trust.untrustedFiles" = "newWindow";
        "security.workspace.trust.startupPrompt" = "never";
        "security.workspace.trust.enabled" = false;

        # Styling
        "workbench.colorTheme" = "Wallbash";
        "window.menuBarVisibility" = "toggle";
        "editor.scrollbar.vertical" = "hidden";
        "editor.scrollbar.verticalScrollbarSize" = 0;
        "editor.semanticTokenColorCustomizations.enabled" = true;
        "editor.bracketPairColorization.independentColorPoolPerBracketType" = true;
        "workbench.colorCustomizations.editorInlayHint.typeBackground" = "#2F3542";
        "window.titleBarStyle" = "custom";
        "editor.minimap.side" = "right";
        "workbench.sideBar.location" = "left";
        "workbench.activityBar.location" = "top";
        "workbench.statusBar.visible" = false;

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
        "editor.inlineSuggest.enabled" = true;
        "files.encoding" = "utf8";

        # Whitespace
        "files.trimTrailingWhitespace" = true;
        "files.trimFinalNewlines" = true;
        "files.insertFinalNewline" = true;
        "diffEditor.ignoreTrimWhitespace" = false;

        # Terminal
        "terminal.external.linuxExec" = "kitty";
        "terminal.explorerKind" = "both";
        "terminal.sourceControlRepositoriesKind" = "both";
        "terminal.integrated.cursorBlinking" = true;
        "terminal.integrated.cursorStyle" = "line";
        "terminal.integrated.cursorWidth" = 2;
        "terminal.integrated.enableImages" = true;

        # Git
        "git.autofetch" = false;
        "git.enableSmartCommit" = true;
        "git.confirmSync" = false;

        #"git.enableCommitSigning" = true;
        #"git-graph.repository.sign.commits" = true;
        #"git-graph.repository.sign.tags" = true;
        #"git-graph.repository.commits.showSignatureStatus" = true;
        "git.enableCommitSigning" = false;
        "git-graph.repository.sign.commits" = false;
        "git-graph.repository.sign.tags" = false;
        "git-graph.repository.commits.showSignatureStatus" = false;

        "git.allowForcePush" = true;
        "git.defaultBranchName" = "master";
        "git.defaultCloneDirectory" = "~/Verkefni";
        "git.openAfterClone" = "alwaysNewWindow";
        "git.pruneOnFetch" = true;
        "git.fetchOnPull" = true;
        "git.pullBeforeCheckout" = true;
        "git.rebaseWhenSync" = true;

        # Other
        "telemetry.telemetryLevel" = "off";
        "update.showReleaseNotes" = false;

        ## Extensions ##

        "workbench.iconTheme" = "material-icon-theme";
        "workbench.productIconTheme" = "material-product-icons";
        "color-highlight.markerType" = "outline";

        "continue.enableTabAutocomplete" = false;
        "continue.telemetryEnabled" = false;

        "errorLens.gutterIconsEnabled" = true;
        "errorLens.messageMaxChars" = 0;

        # Nix
        "alejandra.program" = "alejandra";
        "[nix].editor.defaultFormatter" = "kamadorueda.alejandra";
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";

        "python.analysis.autoImportCompletions" = true;
        "python.analysis.inlayHints.callArgumentNames" = "partial";
        "python.analysis.inlayHints.functionReturnTypes" = true;

        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[json].editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[javascript].editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[typescriptreact].editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[jsonc].editor.defaultFormatter" = "esbenp.prettier-vscode";
        "[markdown].editor.defaultFormatter" = "esbenp.prettier-vscode";

        "gitlens.currentLine.enabled" = false;
        "gitlens.codeLens.enabled" = false;
        "gitlens.hovers.enabled" = false;
        "gitlens.showWelcomeOnInstall" = false;
        "gitlens.plusFeatures.enabled" = false;

        "git-graph.repository.commits.fetchAvatars" = true;

        "gitmoji.onlyUseCustomEmoji" = true;
        "gitmoji.addCustomEmoji" = [
          {
            "emoji" = "✨ NEW:";
            "code" = ":sparkles: NEW:";
            "description" = "... Add new code/feature";
          }
          {
            "emoji" = "⚡ IMPROVE:";
            "code" = ":high_voltage: IMPROVE:";
            "description" = "... Improve existing code/feature";
          }
          {
            "emoji" = "🔥 REMOVE:";
            "code" = ":fire: REMOVE:";
            "description" = "... Remove existing code/feature";
          }
          {
            "emoji" = "🐛 FIX:";
            "code" = ":bug: FIX:";
            "description" = "... Fix a bug";
          }
          {
            "emoji" = "🔧 MAINT:";
            "code" = ":wrench: MAINT:";
            "description" = "... Maintain dependencies and code";
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
        {
          "key" = "alt+f";
          "command" = "editor.action.formatDocument";
          "when" = "editorHasDocumentFormattingProvider && editorTextFocus && !editorReadonly && !inCompositeEditor";
        }
        {
          "key" = "alt+f";
          "command" = "editor.action.formatDocument.none";
          "when" = "editorTextFocus && !editorHasDocumentFormattingProvider && !editorReadonly";
        }
      ];
    };
  };

  home.file = lib.mkMerge [
    {
      # Editor flags
      ".config/codium-flags.conf".source = "${pkgs.hydenix.hyde}/Configs/.config/codium-flags.conf";
    }
  ];
}
