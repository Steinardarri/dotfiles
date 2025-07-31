{
  mkcd = ''
    if test (count $argv) -ne 1
      echo "Usage: mkcd <directory>"
      return 1
    end
    mkdir -p $argv[1] && cd $argv[1]
  '';

  # Find file by name
  ff = ''
    find . -type f -iname "*$argv*" 2>/dev/null
  '';

  # Find directory by name
  fd = ''
    find . -type d -iname "*$argv*" 2>/dev/null
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

  # Quick weather check (requires curl)
  weather = ''
    if test (count $argv) -eq 0
      curl -s "wttr.in/?format=3"
    else
      curl -s "wttr.in/$argv[1]?format=3"
    end
  '';

  # Process killer by name
  killall-fuzzy = ''
    if test (count $argv) -eq 0
      echo "Usage: killall-fuzzy <process_name_pattern>"
      return 1
    end
    ps aux | grep $argv[1] | grep -v grep | awk '{print $2}' | xargs -r kill
  '';

  # yazi shell wrappers
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
  yy = ''
    # Create a temporary file to store Yazi's working directory
    set tmp (mktemp -t "yazi-cwd.XXXXXX")

    # Run Yazi with all arguments passed to this script
    # The --cwd-file flag tells Yazi to write its working directory to the temp file when it exits
    yazi $argv --cwd-file="$tmp"

    # After Yazi exits:
    # 1. Read the contents of the temp file (z flag for null-terminated strings)
    # 2. Check if the directory is not empty
    # 3. Check if it's different from the current directory
    if read -z cwd < "$tmp"; and test -n "$cwd"; and test "$cwd" != "$PWD"
      # Change to the directory Yazi was in when it exited
      builtin cd -- "$cwd"
    end

    # Clean up the temporary file
    rm -f -- "$tmp"
  '';
}
