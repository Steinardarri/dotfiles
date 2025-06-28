{hostname,...}: let
  inherit
    (import ../../../hosts/${hostname}/options.nix)
    theShell
    ;
in {
  programs.helix = {
    enable = true;

    settings = {
      editor = {
        true-color = true;
        shell = ["${theShell}" "-c"];
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
      };
    };
  };

  home.sessionVariables = {
    EDITOR = "helix";
  };
}
