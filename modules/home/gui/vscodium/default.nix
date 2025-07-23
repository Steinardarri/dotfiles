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
        with pkgs.nix-vscode-extensions.open-vsx; [
          # https://raw.githubusercontent.com/nix-community/nix-vscode-extensions/master/data/cache/open-vsx-latest.json

          # Editor
          "1nvitr0".blocksort
          "1nvitr0".list-tools
          jellydn.toggle-excluded-files
          kylinideteam.gitlens # Gitlens lower version for friendly license
          mhutchie.git-graph
          usernamehw.errorlens

          # Aesthetics
          delgan.qml-format
          esbenp.prettier-vscode
          gaplo917.gapstylevs
          jock.svg
          naumovs.color-highlight
          pkief.material-icon-theme
          pkief.material-product-icons
          seatonjiang.gitmoji-vscode

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
          cutetee.qml
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

          # Workflow
          alefragnani.bookmarks
          gruntfuggly.todo-tree
        ]
        # ++ (with pkgs.nix-vscode-extensions.vscode-marketplace; [
        #   # https://raw.githubusercontent.com/nix-community/nix-vscode-extensions/master/data/cache/vscode-marketplace-latest.json
        # ])
        ;

      userSettings = "./settings.json";
      #"git.enableCommitSigning" = true;
      #"git-graph.repository.sign.commits" = true;
      #"git-graph.repository.sign.tags" = true;
      #"git-graph.repository.commits.showSignatureStatus" = true;

      keybindings = "./keybindings.json";
    };
  };

  home.file = lib.mkMerge [
    {
      # Editor flags
      ".config/codium-flags.conf".source = "./codium-flags.conf";
    }
  ];
}
