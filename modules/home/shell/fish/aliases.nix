{
  # eza
  l = "eza -lh --icons=auto";
  ls = "eza -1 --icons=auto";
  ll = "eza -lhga --icons=auto --sort=name --group-directories-first";
  ld = "eza -lhgD --icons=auto";
  lt = "eza --icons=auto --tree";

  # System shortcuts
  c = "clear";
  e = "exit";

  # Networking
  ping = "ping -c 5";

  # File viewing
  cat = "bat --style=auto";
  grep = "rg";
  find = "fd";

  # System monitoring
  top = "btop";
  htop = "btop";

  # 'scripts'
  show_path = "echo $PATH | tr ':' '\n'";
  lsblks = "lsblk -o name,mountpoint,label,partlabel,size,fstype,uuid";
  weather = "curl -s 'wttr.in/Reykjavik?MQ' | rg -v 'Follow'";
  sbv = "readlink /nix/var/nix/profiles/system"; # system build version
}
