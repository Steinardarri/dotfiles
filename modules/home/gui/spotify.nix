{
  pkgs,
  inputs,
  ...
}: {
  # https://gerg-l.github.io/spicetify-nix/
  imports = [
    inputs.spicetify-nix.homeManagerModules.spicetify
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
  };
}
