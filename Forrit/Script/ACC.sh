#!/bin/sh

cd ~/.local/share/applications/
/usr/bin/kioclient exec ./wine-Programs-RealHeadMotion.desktop
/usr/bin/kioclient exec ./wine-Programs-ACCResultsCompanion.desktop
/usr/bin/kioclient exec ./wine-Programs-CrewChiefV4.desktop

~/Forrit/git_verkefni/monocoque/build/monocoque play -v &
konsole --hold --new-tab -e $SHELL -c "~/Forrit/git_verkefni/monocoque/simshmbridge/assets/createsimshm" &
konsole --hold --new-tab -e $SHELL -c "protontricks-launch --appid 805550 ~/Forrit/git_verkefni/monocoque/simshmbridge/assets/simshmbridge.exe" &
