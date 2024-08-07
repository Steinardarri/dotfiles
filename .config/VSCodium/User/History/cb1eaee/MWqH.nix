{...}: {
  programs.starship = {
    enable = true;
    settings = {
      format = "$shell$all";

      character = {
        success_symbol = "[󱦗](bold purple)";
        error_symbol = "[󰐼](bold red)";
      };

      shell = {
        fish_indicator = "Fish";
        bash_indicator = "Bash";
        zsh_indicator = "Zsh";
        powershell_indicator = "PowerShell";
        unknown_indicator = "Unknown shell";
        format = "[ $indicator]($style) ";
        style = "purple bold";
        disabled = false;
      };
      username = {
        style_user = "green bold";
        style_root = "red bold";
        format = "as [$user]($style)";
        disabled = false;
        show_always = true;
      };
      hostname = {
        ssh_only = false;
        format = "@[$hostname](bold green) ";
        disabled = false;
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
      cmd_duration = {format = " [$duration](bold blue) ";};

      # Symbols
      git_branch.style = "242";
      aws.symbol = "  ";
      conda.symbol = " ";
      dart.symbol = " ";
      docker_context.symbol = " ";
      elixir.symbol = " ";
      elm.symbol = " ";
      git_branch.symbol = " ";
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
