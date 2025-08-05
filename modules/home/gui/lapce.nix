_: {
  programs.lapce = {
    enable = true;
    channel = "nightly";

    settings = {
      editor = {
        font-family = "monospace";
        font-size = 14;
        tab-width = 2;
        cursor-surrounding-lines = 4;
        render-whitespace = "none";
        bracket-pair-colorization = true;
        highlight-matching-brackets = true;
      };
      ui = {
        font-size = 20;
        open-editors-visible = false;
      };
    };
  };

  xdg = {
    mimeApps.defaultApplications = {
      "text/plain" = "lapce.desktop";
      "text/x-shellscript" = "lapce.desktop";
      "text/x-csrc" = "lapce.desktop";
      "text/x-c++src" = "lapce.desktop";
      "text/x-java" = "lapce.desktop";
      "text/x-python" = "lapce.desktop";
      "text/x-javascript" = "lapce.desktop";
      "text/x-typescript" = "lapce.desktop";
      "text/x-php" = "lapce.desktop";
      "text/x-ruby" = "lapce.desktop";
      "text/x-perl" = "lapce.desktop";
      "text/x-go" = "lapce.desktop";
      "text/x-rust" = "lapce.desktop";
      "text/x-csharp" = "lapce.desktop";
      "text/x-shader" = "lapce.desktop";
      "text/x-markdown" = "lapce.desktop";
      "text/x-tex" = "lapce.desktop";
      "text/x-toml" = "lapce.desktop";
      "text/x-yaml" = "lapce.desktop";
      "text/x-json" = "lapce.desktop";
      "text/xml" = "lapce.desktop";
      "text/html" = "lapce.desktop";
      "text/css" = "lapce.desktop";
      "text/x-diff" = "lapce.desktop";
      "text/x-patch" = "lapce.desktop";
      "text/x-log" = "lapce.desktop";
      "application/x-shellscript" = "lapce.desktop";
      "application/json" = "lapce.desktop";
      "application/xml" = "lapce.desktop";
      "application/xhtml+xml" = "lapce.desktop";
      "application/x-ruby" = "lapce.desktop";
      "application/x-python" = "lapce.desktop";
      "application/x-javascript" = "lapce.desktop";
      "application/x-perl" = "lapce.desktop";
      "application/x-php" = "lapce.desktop";
      "application/x-tex" = "lapce.desktop";
      "application/x-texinfo" = "lapce.desktop";
      "application/x-troff" = "lapce.desktop";
      "application/x-rpm" = "lapce.desktop";
      "application/x-msdos-program" = "lapce.desktop"; # Batch files
      "application/x-sharedlib" = "lapce.desktop"; # Dynamic libraries (for viewing)
      "application/x-executable" = "lapce.desktop"; # Binary executables (for viewing)
    };
    desktopEntries = {
      lapce = {
        name = "Lapce";
        comment = "Lightning-fast and powerful code editor written in Rust";
        categories = ["Development" "IDE" "Text Editor"];
        genericName = "Code Editor";

        icon = "dev.lapce.lapce";
        exec = "GTK_USE_PORTAL=1 lapce %F";
        mimeType = ["text/plain" "inode/directory"];

        actions = {
          "New Window" = {
            exec = "GTK_USE_PORTAL=1 lapce --new %F";
          };
        };
      };
    };
  };
}
