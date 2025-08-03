{
  pkgs,
  inputs,
  config,
  ...
}: {
  # https://gerg-l.github.io/spicetify-nix/
  imports = [
    inputs.spicetify-nix.homeManagerModules.default
  ];

  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {
    enable = true;

    enabledExtensions = with spicePkgs.extensions; [
      allOfArtist
      betterGenres
      featureShuffle
      fullAppDisplayMod
      playlistIcons
      powerBar
      shuffle
      skipStats
      trashbin
    ];
    enabledCustomApps = with spicePkgs.apps; [
      lyricsPlus
      marketplace
      newReleases
      ncsVisualizer
    ];
    enabledSnippets = with spicePkgs.snippets; [
      betterLyricsStyle
      fixedEpisodesIcon
      fixLikedButton
      fixLikedIcon
      fixListeningOn
      fixListenTogetherButton
      fixNowPlayingIcon
      hideAudiobooksButton
      hideFriendActivityButton
      pointer
    ];

    wayland = true;
    windowManagerPatch = true;

    theme = spicePkgs.themes.hazy;
    colorScheme = "custom";
    customColorScheme = let
      inherit (config.lib.stylix) colors;
    in {
      text = colors.base05;
      subtext = colors.base04;
      main = colors.base00;
      main-elevated = colors.base01;
      main-transition = colors.base01;
      highlight = colors.base02;
      highlight-elevated = colors.base00;
      sidebar = colors.base01;
      player = colors.base01;
      card = colors.base03;
      shadow = colors.base04;
      selected-row = colors.base02;
      button = colors.base0C;
      button-active = colors.base0D;
      button-disabled = colors.base03;
      tab-active = colors.base02;
      notification = colors.base06;
      notification-error = colors.base08;
      misc = colors.base04;
      play-button = colors.base06;
      play-button-active = colors.base0F;
      progress-fg = colors.base02;
      progress-bg = colors.base01;
      heart = colors.base09;
      pagelink-active = colors.base05;
      radio-btn-active = colors.base0E;
    };
  };
}
