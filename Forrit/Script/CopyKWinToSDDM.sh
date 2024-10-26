#! /bin/bash

cp ~/.config/kwinoutputconfig.json /var/lib/sddm/.config/
chown sddm:sddm /var/lib/sddm/.config/kwinoutputconfig.json
