# https://github.com/the-argus/spicetify-nix/blob/master/THEMES.md
# https://github.com/the-argus/spicetify-nix/blob/master/EXTENSIONS.md
# https://github.com/the-argus/spicetify-nix/blob/master/CUSTOMAPPS.md
{
  pkgs,
  username,
  inputs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.packages.${pkgs.system}.default;
in {
  imports = [
    inputs.spicetify-nix.homeManagerModule
  ];

  programs.spicetify = {
    enable = true;
    theme = spicePkgs.themes.Dribbblish;
    colorScheme = "rosepine";

    enabledExtensions = with spicePkgs.extensions; [
      fullAppDisplayMod
      shuffle # shuffle+ (special characters are sanitized out of ext names)
      # hidePodcasts
      trashbin
      playlistIcons
      fullAlbumDate
      skipStats
      songStats
      playNext
    ];

    enabledCustomApps = with spicePkgs.apps; [
      new-releases
      lyrics-plus
      reddit
      {
        name = "localFiles";
        src = /home/${username}/Music;
        appendName = false;
      }
    ];
  };
}
