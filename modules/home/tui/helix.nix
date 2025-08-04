_: {
  programs.helix = {
    enable = true;

    settings = {
      editor = {
        true-color = true;
        shell = ["fish" "-c"];
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
    };
  };

  home.sessionVariables = {
    # EDITOR = "helix";
  };
}
