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
}
