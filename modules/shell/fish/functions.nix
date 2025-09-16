{
  mkcd = ''
    if test (count $argv) -ne 1
      echo "Usage: mkcd <directory>"
      return 1
    end
    mkdir -p $argv[1] && cd $argv[1]
  '';

  # Quick file search with preview using fzf
  fzf-file = ''
    fzf --preview 'bat --style=numbers --color=always {}'
  '';

  # Quick backup of a file
  backup = ''
    if test (count $argv) -ne 1
      echo "Usage: backup <file>"
      return 1
    end
    cp $argv[1] $argv[1].bak.(date +%Y%m%d_%H%M%S)
  '';

  # Show disk usage for current directory
  du-here = ''
    du -h --max-depth=1 . | sort -hr
  '';

  # Process killer by name
  killall-fuzzy = ''
    if test (count $argv) -eq 0
      echo "Usage: killall-fuzzy <process_name_pattern>"
      return 1
    end
    ps aux | grep $argv[1] | grep -v grep | awk '{print $2}' | xargs -r kill
  '';

  # yazi second shell wrapper
  y = ''
    # Check if any arguments were provided
    if test -n "$argv[1]"
      # If first argument is a directory, pass it to yy
      if test -d "$argv[1]"
        yy "$argv[1]"
      else
        # Use zoxide to resolve the directory alias
        set resolved_dir (zoxide query "$argv[1]")
        yy "$resolved_dir"
      end
    else
      # No arguments provided, run yy in current directory
      yy
    end

    # Return the exit status of the last command
    return $status
  '';
}
