_: {
  # Starship overrides
  programs.starship = {
    enable = true;
    settings = {
      format = "$shell$all";
      add_newline = true;
      command_timeout = 10000;

      character = {
        success_symbol = "[󱢿](bold purple)";
        error_symbol = "[󰯈](bold red)";
      };

      shell = {
        disabled = false;
        fish_indicator = "";
        bash_indicator = "";
        zsh_indicator = "󰬡";
        unknown_indicator = "󰇥";
        format = "[$indicator]($style) ";
        style = "bold purple";
      };
      shlvl = {
        disabled = false;
        format = "[$symbol]($style) ";
        repeat = true;
        symbol = "❯";
        repeat_offset = 1;
        threshold = 0;
      };
      username = {
        disabled = false;
        style_user = "green bold";
        style_root = "red bold";
        format = "as [$user]($style)";
        show_always = true;
      };
      hostname = {
        disabled = false;
        ssh_only = false;
        format = "@[$hostname](bold green) ";
      };
      directory = {
        read_only = " ";
        format = "in [$path]($style)[$read_only]($read_only_style) ";
        truncate_to_repo = false;
        truncation_length = 8;
        style = "bold blue";
        truncation_symbol = "../";
        home_symbol = " ~";
      };
      cmd_duration.format = " [$duration](bold blue) ";

      # Symbols
      git_branch = {
        style = "242";
        symbol = " ";
      };
      aws.symbol = "  ";
      conda.symbol = " ";
      dart.symbol = " ";
      docker_context.symbol = " ";
      elixir.symbol = " ";
      elm.symbol = " ";
      golang.symbol = " ";
      haskell.symbol = " ";
      java.symbol = " ";
      julia.symbol = " ";
      memory_usage.symbol = "󰍛 ";
      nim.symbol = " ";
      nix_shell = {
        symbol = " ";
        impure_msg = "impure";
        pure_msg = "pure";
        format = "via [$symbol$state $name](bold blue) ";
      };
      perl.symbol = " ";
      php.symbol = " ";
      python = {
        symbol = " ";
        python_binary = ["py" "python3" "python2.7"];
      };
      ruby.symbol = " ";
      rust.symbol = " ";
      scala.symbol = " ";
      swift.symbol = " ";
    };
  };
}
