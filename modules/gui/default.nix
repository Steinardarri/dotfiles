_: {
  imports = [
    ./spotify.nix
    ./vscodium.nix
  ];

  home.sessionVariables = {
    AMD_VULKAN_ICD = "RADV";
  };
}
