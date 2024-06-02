{
  pkgs,
  lib,
  hostname,
  username,
  ...
}: let
  inherit (import ../../hosts/${hostname}/options.nix) browser;
  firefoxAddons = pkgs.nur.repos.rycee.firefox-addons;
in
  lib.mkIf (browser == "floorp") {
    programs.firefox = {
      enable = true;
      package = pkgs.firefox-wayland;

      policies = {
        DisableTelemetry = true;
        DisableFirefoxStudies = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        DisablePocket = true;
        DisableFirefoxAccounts = false;
        DisableAccounts = false;
        DisableFirefoxScreenshots = true;
        OverrideFirstRunPage = "";
        OverridePostUpdatePage = "";
        DontCheckDefaultBrowser = true;
        DisplayBookmarksToolbar = "always";
        DisplayMenuBar = "always";
        SearchBar = "unified";
      };

      profiles.${username} = {
        search.engines = {
          "MyNixOS" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = ["@nix"];
          };
          "NerdFonts" = {
            urls = [
              {
                template = "https://www.nerdfonts.com/cheat-sheet";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "";
            definedAliases = ["@nerdf"];
          };
        };
        search.force = true;

        settings = {
          "dom.security.https_only_mode" = true;
          "browser.download.panel.shown" = true;
        };

        extensions = with firefoxAddons; [
          ublock-origin
          proton-pass
          darkreader
          re-enable-right-click
          behind-the-overlay-revival
          sponsorblock
          betterttv
          plasma-integration
          clearurls
          indie-wiki-buddy
          reddit-enhancement-suite
          search-by-image
          web-archives
          privacy-badger
          flagfox
        ];
      };
    };
  }
