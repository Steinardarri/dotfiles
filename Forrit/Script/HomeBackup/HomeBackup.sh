#!/usr/bin/env zsh

uptime=$(cut -f1 -d'.' < /proc/uptime)

if ((uptime < 120)); then
  sleep $((120 - uptime));
fi

cd /home/steinardth/Forrit/Script/HomeBackup
last=$(<last_transfusion.txt)
date=$(date +%s)
delta_seconds=$(($date - $last))

if ((delta_seconds > 86400)); then
  kdialog --title "Making a full backup of Home folder" --passivepopup \
  "Making a Plasma transfusion backup" 10
  /home/steinardth/Forrit/transfuse/transfuse-full-backup.sh && date +%s >| last_transfusion.txt
else
  kdialog --title "Making a full backup of Home folder" --passivepopup \
  "Skipping the Plasma transfusion backup" 3
fi

kdialog --title "Making a full backup of Home folder" --passivepopup \
  "rsyncing to backup location" 10
rsync -r -t -p -o -g -v --progress -u -s --exclude-from=/home/steinardth/.config/grsync/home-backup-exclude.txt /home/steinardth /run/media/steinardth/Hardur_Diskur/Backup

kdialog --title "Backup finished" --passivepopup \
"😎" 5
