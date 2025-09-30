_: {
  imports = [
    # ./spotify.nix borked for now
    ./vscodium.nix
  ];

  home.sessionVariables = {
    AMD_VULKAN_ICD = "RADV";
  };
}
