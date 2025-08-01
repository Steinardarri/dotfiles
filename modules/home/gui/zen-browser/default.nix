{
  pkgs,
  inputs,
  ...
}: {
  home.packages = [inputs.zen-browser.packages.${pkgs.system}.zen-browser];

  # Declaratively manage CSS files for Zen Browser
  # This will apply to all Zen Browser profiles
  home.file = {
    ".zen/7s8qq7dj.Default Profile/chrome/userContent.css" = {
      source = ./userContent.css;
      force = true;
    };
    ".zen/7s8qq7dj.Default Profile/chrome/userChrome.css" = {
      source = ./userChrome.css;
      force = true;
    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = "zen.desktop";
    "x-scheme-handler/http" = "zen.desktop";
    "x-scheme-handler/https" = "zen.desktop";
    "x-scheme-handler/chrome" = "zen.desktop";
    "x-scheme-handler/unknown" = "zen.desktop";
    "application/x-extension-htm" = "zen.desktop";
    "application/x-extension-html" = "zen.desktop";
    "application/x-extension-shtml" = "zen.desktop";
    "application/xhtml+xml" = "zen.desktop";
    "application/x-extension-xhtml" = "zen.desktop";
    "application/x-extension-xht" = "zen.desktop";
  };

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_USE_XINPUT2 = "1";
  };
}
