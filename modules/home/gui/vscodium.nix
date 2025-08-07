{
  pkgs,
  lib,
  ...
}: {
  # VSCode -> VSCodium overrides
  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    mutableExtensionsDir = false;

    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;

      extensions =
        with pkgs.nix-vscode-extensions.open-vsx;
          [
            # https://raw.githubusercontent.com/nix-community/nix-vscode-extensions/master/data/cache/open-vsx-latest.json

            # Editor
            jellydn.toggle-excluded-files
            kylinideteam.gitlens # Gitlens lower version for friendly license
            mhutchie.git-graph
            usernamehw.errorlens
            editorconfig.editorconfig

            # Aesthetics
            esbenp.prettier-vscode
            gaplo917.gapstylevs
            jock.svg
            pkief.material-icon-theme
            pkief.material-product-icons
            seatonjiang.gitmoji-vscode
            naumovs.color-highlight

            # Toolset
            christian-kohler.path-intellisense
            fill-labs.dependi
            firefox-devtools.vscode-firefox-debug
            formulahendry.code-runner
            semanticdiff.semanticdiff
            wix.vscode-import-cost

            # AI
            continue.continue

            # Language specific
            bmalehorn.vscode-fish
            charliermarsh.ruff
            detachhead.basedpyright
            ewen-lbh.vscode-hyprls
            foxundermoon.shell-format
            james-yu.latex-workshop
            jnoortheen.nix-ide
            ndonfris.fish-lsp
            rust-lang.rust-analyzer
            svelte.svelte-vscode
            tamasfe.even-better-toml
            timonwong.shellcheck
            yzhang.markdown-all-in-one
            redhat.vscode-yaml

            # Workflow
            alefragnani.bookmarks
            gruntfuggly.todo-tree
            mkhl.direnv
          ]
          ++ [
            # Complications with name starting with digit
            pkgs.nix-vscode-extensions.open-vsx."1nvitr0".blocksort
            pkgs.nix-vscode-extensions.open-vsx."1nvitr0".list-tools
          ]
        # ++ (with pkgs.nix-vscode-extensions.vscode-marketplace; [
        #   # https://raw.githubusercontent.com/nix-community/nix-vscode-extensions/master/data/cache/vscode-marketplace-latest.json
        # ])
        ;

      userSettings = {
        "[javascript]" = {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
        };
        "[nix]" = {
          "editor.defaultFormatter" = "jnoortheen.nix-ide";
        };
        "[python]" = {
          "editor.defaultFormatter" = "charliermarsh.ruff";
        };
        "[properties]" = {
          "editor.defaultFormatter" = "foxundermoon.shell-format";
        };
        "[qml]" = {
          "editor.defaultFormatter" = "Delgan.qml-format";
        };
        "[rust]" = {
          "editor.defaultFormatter" = "rust-lang.rust-analyzer";
        };
        "[shellscript]" = {
          "editor.defaultFormatter" = "foxundermoon.shell-format";
        };

        "chat.commandCenter.enabled" = false;
        "color-highlight.markerType" = "dot-before";
        "color-highlight.markRuler" = false;
        "color-highlight.matchHslWithNoFunction" = true;
        "color-highlight.matchRgbWithNoFunction" = true;
        "color-highlight.matchWords" = false;
        "continue.enableTabAutocomplete" = false;
        "continue.telemetryEnabled" = false;
        "diffEditor.maxComputationTime" = 0;

        "editor.bracketPairColorization.independentColorPoolPerBracketType" = true;
        "editor.defaultFormatter" = "esbenp.prettier-vscode";
        "editor.fontFamily" = lib.mkDefault "'Hack Nerd Font Mono', 'Hack', monospace";
        "editor.fontSize" = lib.mkDefault 16;
        "editor.fontLigatures" = false;
        "editor.formatOnPaste" = true;
        "editor.formatOnSave" = true;
        "editor.guides.bracketPairs" = "active";
        "editor.inlineSuggest.enabled" = true;
        "editor.minimap.showSlider" = "always";
        "editor.minimap.side" = "right";
        "editor.quickSuggestions" = {
          "strings" = "on";
          "comments" = "inline";
          "other" = "on";
        };
        "editor.scrollbar.vertical" = "hidden";
        "editor.scrollbar.verticalScrollbarSize" = 0;
        "editor.tabCompletion" = "onlySnippets";
        "editor.tabSize" = 2;
        "editor.wordWrap" = "bounded";
        "editor.wordWrapColumn" = 160;
        "editor.wrappingIndent" = "deepIndent";

        "errorLens.codeLensEnabled" = true;
        "errorLens.gutterIconsEnabled" = true;
        "errorLens.gutterIconSet" = "emoji";
        "errorLens.messageMaxChars" = 0;

        "evenBetterToml.formatter.alignComments" = true;
        "evenBetterToml.formatter.alignEntries" = true;
        "evenBetterToml.formatter.allowedBlankLines" = 2;
        "evenBetterToml.formatter.arrayAutoCollapse" = true;
        "evenBetterToml.formatter.arrayAutoExpand" = true;
        "evenBetterToml.formatter.arrayTrailingComma" = true;
        "evenBetterToml.formatter.columnWidth" = 80;
        "evenBetterToml.formatter.compactArrays" = false;
        "evenBetterToml.formatter.indentEntries" = true;
        "evenBetterToml.formatter.indentString" = "  ";
        "evenBetterToml.formatter.reorderArrays" = true;
        "evenBetterToml.formatter.trailingNewline" = true;

        "explorer.compactFolders" = false;
        "explorer.confirmDragAndDrop" = false;
        "explorer.confirmDelete" = false;
        "explorer.confirmPasteNative" = false;
        "extensions.autoCheckUpdates" = false;

        "files.autoSave" = "afterDelay";
        "files.encoding" = "utf8";
        "files.insertFinalNewline" = true;
        "files.trimFinalNewlines" = true;
        "files.trimTrailingWhitespace" = true;

        "git-graph.repository.commits.fetchAvatars" = true;
        "git-graph.repository.commits.showSignatureStatus" = true;
        "git-graph.repository.sign.commits" = true;
        "git-graph.repository.sign.tags" = true;

        "git.allowForcePush" = true;
        "git.autofetch" = true;
        "git.confirmForcePush" = false;
        "git.confirmSync" = false;
        "git.defaultBranchName" = "master";
        "git.defaultCloneDirectory" = "~/Verkefni";
        "git.enableCommitSigning" = true;
        "git.enableSmartCommit" = true;
        "git.fetchOnPull" = true;
        "git.openAfterClone" = "alwaysNewWindow";
        "git.openRepositoryInParentFolders" = "never";
        "git.pruneOnFetch" = true;
        "git.pullBeforeCheckout" = true;
        "git.rebaseWhenSync" = true;

        "gitlens.codeLens.enabled" = false;
        "gitlens.currentLine.enabled" = false;
        "gitlens.hovers.enabled" = false;
        "gitlens.showWelcomeOnInstall" = false;

        "gitmoji.addCustomEmoji" = [
          {
            "code" = ":sparkles:";
            "description" = "| Add new code/feature";
            "emoji" = "✨";
          }
          {
            "code" = ":high_voltage:";
            "description" = "| Improve existing code/feature";
            "emoji" = "⚡";
          }
          {
            "code" = ":fire:";
            "description" = "| Remove existing code/feature";
            "emoji" = "🔥";
          }
          {
            "code" = ":bug:";
            "description" = "| Fix a bug";
            "emoji" = "🐛";
          }
          {
            "code" = ":wrench:";
            "description" = "| Maintain dependencies and code";
            "emoji" = "🔧";
          }
          {
            "code" = ":bookmark_tabs:";
            "description" = "| Anything related to documentation";
            "emoji" = "📑";
          }
          {
            "code" = ":robot:";
            "description" = "| Anything realted to tests";
            "emoji" = "🤖";
          }
        ];
        "gitmoji.onlyUseCustomEmoji" = true;

        "nix.enableLanguageServer" = true;
        "nix.hiddenLanguageServerErrors" = ["textDocument/definition"];
        "nix.serverPath" = "nixd";
        "nix.serverSettings" = {
          "nixd" = {
            "formatting" = {
              "command" = ["alejandra"];
            };
            # options = {
            #   nixos = {
            #     expr = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.<name>.options";
            #   };
            #   home-manager = {
            #     expr = "(builtins.getFlake (builtins.toString ./.)).nixosConfigurations.<name>.options.home-manager.users.type.getSubOptions []";
            #   };
            # };
          };
        };

        "ruff.nativeServer" = "on";
        "security.workspace.trust.enabled" = true;
        "security.workspace.trust.startupPrompt" = "never";
        "security.workspace.trust.untrustedFiles" = "open";
        "svelte.enable-ts-plugin" = true;
        "telemetry.telemetryLevel" = "off";

        "terminal.explorerKind" = "both";
        "terminal.external.linuxExec" = "kitty";
        "terminal.integrated.copyOnSelection" = true;
        "terminal.integrated.cursorBlinking" = true;
        "terminal.integrated.cursorStyle" = "line";
        "terminal.integrated.cursorWidth" = 2;
        "terminal.integrated.defaultProfile.linux" = "fish";
        "terminal.integrated.enableImages" = true;
        "terminal.integrated.fontSize" = lib.mkDefault 14;
        "terminal.integrated.persistentSessionScrollback" = 5000;
        "terminal.integrated.profiles.linux" = {
          "fish" = {
            "path" = "fish";
            "args" = ["-i"];
            "icon" = "star";
          };
          "bash" = null;
          "zsh" = null;
        };
        "terminal.integrated.scrollback" = 50000;
        "terminal.integrated.smoothScrolling" = true;
        "terminal.integrated.shellIntegration.enabled" = true;
        "terminal.integrated.shellIntegration.environmentReporting" = true;
        "terminal.integrated.suggest.enabled" = true;
        "terminal.integrated.stickyScroll.enabled" = true;
        "terminal.sourceControlRepositoriesKind" = "both";

        "update.mode" = "none";
        "update.showReleaseNotes" = false;
        "window.customMenuBarAltFocus" = false;
        "window.customTitleBarVisibility" = "auto";
        "window.menuBarVisibility" = "visible";
        "window.titleBarStyle" = "custom";
        "window.zoomLevel" = 1;

        "workbench.activityBar.location" = "top";
        "workbench.cloudChanges.autoResume" = "off";
        "workbench.cloudChanges.continueOn" = "off";
        "workbench.colorCustomizations.editorInlayHint.typeBackground" = "#444b6a";
        "workbench.colorTheme" = lib.mkDefault "GapStyle VS";
        "workbench.enableExperiments" = false;
        "workbench.iconTheme" = "material-icon-theme";
        "workbench.navigationControl.enabled" = false;
        "workbench.productIconTheme" = "material-product-icons";
        "workbench.sideBar.location" = "left";
        "workbench.startupEditor" = "none";
        "workbench.statusBar.visible" = true;

        "yaml.schemas" = {
          "file:///home/steinardth/.vscode-oss/extensions/continue.continue/config-yaml-schema.json" = [
            ".continue/**/*.yaml"
          ];
        };
      };

      keybindings = [
        {
          command = "editor.action.blockComment";
          key = "ctrl+shift+numpad_divide";
          when = "editorTextFocus && !editorReadonly";
        }
        {
          command = "-editor.action.blockComment";
          key = "shift+alt+a";
          when = "editorTextFocus && !editorReadonly";
        }
        {
          command = "editor.action.commentLine";
          key = "ctrl+numpad_divide";
          when = "editorTextFocus && !editorReadonly";
        }
        {
          command = "-editor.action.commentLine";
          key = "ctrl+oem_2";
          when = "editorTextFocus && !editorReadonly";
        }
        {
          key = "ctrl+f6";
          command = "workbench.action.reloadWindow";
          when = "-";
        }
        {
          key = "alt+f";
          command = "editor.action.formatDocument";
          when = "editorHasDocumentFormattingProvider && editorTextFocus && !editorReadonly && !inCompositeEditor";
        }
        {
          key = "ctrl+shift+i";
          command = "-editor.action.formatDocument";
          when = "editorHasDocumentFormattingProvider && editorTextFocus && !editorReadonly && !inCompositeEditor";
        }
        {
          key = "alt+f";
          command = "editor.action.formatDocument.none";
          when = "editorTextFocus && !editorHasDocumentFormattingProvider && !editorReadonly";
        }
        {
          key = "ctrl+shift+i";
          command = "-editor.action.formatDocument.none";
          when = "editorTextFocus && !editorHasDocumentFormattingProvider && !editorReadonly";
        }
        {
          key = "shift+alt+f";
          command = "editor.action.formatSelection";
          when = "editorHasDocumentSelectionFormattingProvider && editorTextFocus && !editorReadonly";
        }
        {
          key = "ctrl+k ctrl+f";
          command = "-editor.action.formatSelection";
          when = "editorHasDocumentSelectionFormattingProvider && editorTextFocus && !editorReadonly";
        }
        {
          key = "shift+alt+f";
          command = "-filesExplorer.findInFolder";
          when = "explorerResourceIsFolder && filesExplorerFocus && foldersViewVisible && !inputFocus";
        }
        {
          key = "shift+alt+f";
          command = "-search.action.restrictSearchToFolder";
          when = "folderMatchWithResourceFocus && searchViewletVisible";
        }
      ];
    };
  };

  home.file.".config/codium-flags.conf".text = "--ozone-platform=wayland";
}
