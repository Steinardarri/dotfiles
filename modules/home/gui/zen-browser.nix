{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser = {
    enable = true;

    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;

      settings = {
        "extensions.autoDisableScopes" = 0;
        "browser.download.start_downloads_in_tmp_dir" = true;
        "browser.ml.linkPreview.enabled" = true;
        "browser.tabs.groups.enabled" = true;
        "browser.tabs.groups.smart.enabled" = true;
        "cookiebanners.service.mode" = 2;
        "cookiebanners.service.mode.privateBrowsing" = 2;
        "cookiebanners.ui.desktop.enabled" = 2;
        "media.videocontrols.picture-in-picture.enable-when-switching-tabs.enabled" = false;
        "distribution.searchplugins.defaultLocale" = "en-GB";
        "general.useragent.locale" = "en-GB";
        "browser.search.isUS" = false;
      };

      search = {
        force = true;
        default = "ddg";
        engines = {
          "ddg" = {
            urls = [{template = "https://duckduckgo.com/?q={searchTerms}&ia=web";}];
            icon = "https://duckduckgo.com/favicon.ico";
            definedAliases = ["@ddg"];
          };
          "protondb" = {
            urls = [{template = "https://protondb.com/search?q={searchTerms}";}];
            icon = "https://protondb.com/favicon.ico";
            definedAliases = ["@pdb"];
          };
          "github" = {
            urls = [{template = "https://github.com/search?q={searchTerms}";}];
            icon = "https://github.com/favicon.ico";
            definedAliases = ["@gh"];
          };
          "alternativeto" = {
            urls = [{template = "https://alternativeto.net/browse/search/?q={searchTerms}";}];
            icon = "https://alternativeto.net/favicon.ico";
            definedAliases = ["@alt"];
          };
          "youtube" = {
            urls = [{template = "https://www.youtube.com/results?search_query={searchTerms}";}];
            icon = "https://www.youtube.com/favicon.ico";
            definedAliases = ["@yt"];
          };
          "nixos-wiki" = {
            urls = [{template = "https://wiki.nixos.org/w/index.php?search={searchTerms}";}];
            icon = "https://wiki.nixos.org/favicon.png";
            definedAliases = ["@nw"];
          };
          "mynixos" = {
            urls = [{template = "https://mynixos.com/search?q={searchTerms}";}];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@no"];
          };
          "nix-packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@np"];
          };
        };
      };

      extensions = {
        packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          darkreader
          privacy-badger
          proton-pass
          augmented-steam
          re-enable-right-click
          behind-the-overlay-revival
          betterttv
          github-file-icons
          flagfox
          imagus
          indie-wiki-buddy
          protondb-for-steam
          return-youtube-dislikes
          search-by-image
          translate-web-pages
        ];
      };

      userChrome = lib.mkDefault ''
        :root:not([inDOMFullscreen="true"]):not([chromehidden~="location"]):not([chromehidden~="toolbar"]) {
          & #tabbrowser-tabbox #tabbrowser-tabpanels .browserSidebarContainer {
            & browser[transparent="true"] {
              background: none !important;
            }
          }
        }
      '';
    };

    policies = {
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
    };
  };

  xdg.mimeApps.defaultApplications = {
    "text/html" = "zen-beta.desktop";
    "x-scheme-handler/http" = "zen-beta.desktop";
    "x-scheme-handler/https" = "zen-beta.desktop";
    "x-scheme-handler/chrome" = "zen-beta.desktop";
    "x-scheme-handler/unknown" = "zen-beta.desktop";
    "application/x-extension-htm" = "zen-beta.desktop";
    "application/x-extension-html" = "zen-beta.desktop";
    "application/x-extension-shtml" = "zen-beta.desktop";
    "application/xhtml+xml" = "zen-beta.desktop";
    "application/x-extension-xhtml" = "zen-beta.desktop";
    "application/x-extension-xht" = "zen-beta.desktop";
  };

  home.sessionVariables = {
    BROWSER = "zen-beta";
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_USE_XINPUT2 = "1";
  };
}
