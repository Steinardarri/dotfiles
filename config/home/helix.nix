{...}: {
  programs.helix = {
    enable = true;

    settings = {
      editor = {
        true-color = true;
        shell = ["zsh" "-c"];
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
    };
  };
}
