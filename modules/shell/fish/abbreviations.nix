{
  # Directories
  ".." = "cd ..";
  "..." = "cd ../..";
  ".3" = "cd ../../..";
  ".4" = "cd ../../../..";
  ".5" = "cd ../../../../..";
  mkdir = "mkdir -p";

  # Safety nets
  rm = "rm -I";
  cp = "cp -i";
  mv = "mv -i";
  home-manager = "home-manager -b hm-backup";

  shutdown = "systemctl poweroff";
  reboot = "systemctl reboot";
  man = "batman";
  fd = "fd -E 'nix/store' -E 'nix/var/log'";
  rg = "rg -.";
}
