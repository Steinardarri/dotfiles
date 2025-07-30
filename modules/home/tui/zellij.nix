{...}: {
  programs.zellij = {
    enable = true;

    # Auto start
    enableFishIntegration = false;
    enableZshIntegration = false;
    attachExistingSession = false;

    # Will add stuff later
  };
}
