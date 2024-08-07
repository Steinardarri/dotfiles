#!/usr/bin/env zsh

COVERED=1
CHARTS=1

HELP=$(cat <<EOF

########################################################################
#                                                                      #
#   TRANSFUSE                                                          #
#                                                                      #
#   A Script to Backup and Restore KDE Plasma Desktop Configurations   #
#                                                                      #
#   Usage: transfuse.sh [option] [USER/PATIENT]                        #
#                                                                      #
#   Options:                                                           #
#    -h   --help                                      show this help   #
#    -b   --backup USER               copy and compress USER configs   #
#    -bt  --backupt USER                 backup USER appearance only   #
#    -BR  --backuproot                           backup root configs   #
#    -C   --copy USER                       copy but do not compress   #
#    -c   --compress                         compress copied configs   #
#    -p   --pkglists               create list of installed packages * #
#    -pr  --pkgrestore                        install native pkglist * #
#    -pra --pkgrestorealien                    install alien pkglist * #
#    -r   --restore PATIENT             restore configs /to/ PATIENT   #
#                                                                      #
#                                $(tput smul) NOTES $(tput rmul)                               #
#   Environment Variable        COVERED=1       Skip wallpaper steps   #
#   Environment Variable        CHARTS=1         More verbose output   #
#   (*) pkg* options require pacman package manager or an AUR helper   #
#                                                                      #
########################################################################

EOF
)

if [ "$EUID" = 0 ];
then echo -e "\n Do not run this script as root!\n";
    exit;
fi

NOW=$(date +"%Y%m%d_%H%M")

_transfuse_confused() {
    echo -e "\n I dont know what to do.";
    echo "$HELP";
}

_transfuse_copa() {
    mkdir -p ./"$YOU"_transfusion_"$NOW";
    mkdir -p ./"$YOU"_transfusion_"$NOW"/.config;
    mkdir -p ./"$YOU"_transfusion_"$NOW"/.kde;
    mkdir -p ./"$YOU"_transfusion_"$NOW"/.local/share;
}

_transfuse_copt() {
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/auroraerc ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/breezerc ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/dolphinrc ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/gtk* ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/katemetainfos ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/katerc ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/kateschemarc ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/kcmfonts ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/kcminputrc ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/KDE ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/kde.org ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/kdeglobals ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/klaunchrc ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/konsolerc ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/kscreenlockerrc ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/ksplashrc ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/kvantum ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/kwinrc ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/kwinrulesrc ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/latte ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/lattedockrc ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/menus ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/plasma*rc ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/qtcurve ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/Trolltech.conf ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/xsettingsd ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.gtkrc-2.0 ./"$YOU"_transfusion_"$NOW"/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.kde ./"$YOU"_transfusion_"$NOW"/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.local/share/aurorae ./"$YOU"_transfusion_"$NOW"/.local/share/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.local/share/color-schemes ./"$YOU"_transfusion_"$NOW"/.local/share/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.local/share/icons ./"$YOU"_transfusion_"$NOW"/.local/share/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.local/share/fonts ./"$YOU"_transfusion_"$NOW"/.local/share/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.local/share/kfontinst ./"$YOU"_transfusion_"$NOW"/.local/share/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.local/share/konsole ./"$YOU"_transfusion_"$NOW"/.local/share/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.local/share/kxmlgui5 ./"$YOU"_transfusion_"$NOW"/.local/share/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.local/share/plasma ./"$YOU"_transfusion_"$NOW"/.local/share/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.local/share/plasma_icons ./"$YOU"_transfusion_"$NOW"/.local/share/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.local/share/wallpapers ./"$YOU"_transfusion_"$NOW"/.local/share/;
}

_transfuse_copy() {
    _transfuse_copa
    mkdir -p ./"$YOU"_transfusion_"$NOW"/.kde4;
    _transfuse_copt
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/akonadi* ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/autostart* ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/kaccessrc ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/kate ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/katevirc ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/kdeconnect ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/kded5rc ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/kdedefaults ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/kglobalshortcutsrc ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/khotkeysrc ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/kiorc ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/klipperrc ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/kmixrc ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/kprivacyrc ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/krunnerrc ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/ksmserverrc ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/plasma-workspace ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/plasma_calendar_holiday_regions ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/plasmaparc ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/portals.conf ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/powerdevilrc ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/powermanagementprofilesrc ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/pulse/*.conf ./"$YOU"_transfusion_"$NOW"/.config/pulse/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/systemd ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.config/wireplumber ./"$YOU"_transfusion_"$NOW"/.config/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.kde4 ./"$YOU"_transfusion_"$NOW"/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.local/share/applications ./"$YOU"_transfusion_"$NOW"/.local/share/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.local/share/dolphin ./"$YOU"_transfusion_"$NOW"/.local/share/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.local/share/kate ./"$YOU"_transfusion_"$NOW"/.local/share/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.local/share/knewstuff* ./"$YOU"_transfusion_"$NOW"/.local/share/;
    rsync -rltD --ignore-missing-args /home/"$YOU"/.local/share/kservices5 ./"$YOU"_transfusion_"$NOW"/.local/share/;
}

_transfuse_homechck() {
    if [ ! -d "/home/$YOU" ]; then
        echo -e "\n Directory /home/$YOU does not exist.\n";
        exit;
    fi;
}

_transfuse_restore() {
    echo -e "\nConfigs Restored from ""$opt""\n\nCycling Color Scheme and Reloading Plasma.\n" ;
    qdbus org.kde.kded5 /modules/khotkeys org.kde.khotkeys.reread_configuration ;
    kquitapp5 plasmashell && kstart5 plasmashell </dev/null &>/dev/null &
    killall kglobalaccel5 </dev/null &>/dev/null &
    kstart5 kglobalaccel5 </dev/null &>/dev/null &
    sleep 0.5;
    CLRSCH=$(plasma-apply-colorscheme --list-schemes | awk '$3 == "(current" { print $2 }');
    FSTSCH=$(plasma-apply-colorscheme --list-schemes | head -n2 | tail -n1 | awk '{ print $2 }');
    LSTSCH=$(plasma-apply-colorscheme --list-schemes | awk '{ print $2 }' | tail -n1);
    plasma-apply-colorscheme "$FSTSCH" || plasma-apply-colorscheme "$LSTSCH" ;
    plasma-apply-colorscheme "$CLRSCH" ;
    qdbus org.kde.KWin /KWin reconfigure
    if [[ $(loginctl show-session $(awk -v u="$USER" '$0 ~ u{ print $1}'<<<"$(loginctl)") -p Type | awk -F '=' 'NR==1 { print $2 }') = "x11" ]]; then
        kwin_x11 --replace </dev/null &>/dev/null &
    elif [[ $(loginctl show-session $(awk -v u="$USER" '$0 ~ u{ print $1}'<<<"$(loginctl)") -p Type | awk -F '=' 'NR==1 { print $2 }') = "wayland" ]]; then
        kwin_wayland --replace </dev/null &>/dev/null &
    fi;
    if [ -z "$COVERED" ]; then
        NEWFLWR=$(find /home/"$PATIENT"/.local/share/wallpapers -name "flowers.*");
        plasma-apply-wallpaperimage "$NEWFLWR" ;
    else
        echo -e '\n You are "Covered", meaning no change will be made to configured wallpaper selection.\n That, or there was an error, in which case yell at cscs.';
    fi;
    kquitapp5 plasmashell && kstart5 plasmashell </dev/null &>/dev/null &
}

_transfuse_users() {
    _tf_users=$(getent passwd {1000..2000} | awk -F':' '{ print $1}' | sort -u | tr '\n' '  ');
    echo -e "\nAvailable Users:  ""$_tf_users""\n";
}

if [ $# -eq 0 ];
then echo "";
    while true; do
        PS3=$'\n'"Please enter your choice: "
        options=("Backup" "Copy" "Compress" "Restore" "Help" "Quit")
        COLUMNS=26
        select opt in "${options[@]}"
        do
            case "$opt,$REPLY" in
                Backup,*|*,[bB]ackup)
                    _transfuse_users
                    read -rp "Please enter the name of the user to backup and compress configs from: "  YOU
                    "$0" -b "$YOU";
                    break
                    ;;
                Copy,*|*,[cC]opy)
                    _transfuse_users
                    read -rp "Please enter the name of the user to copy configs from: "  YOU
                    "$0" -C "$YOU";
                    break
                    ;;
                Compress,*|*,[cC]ompress)
                    "$0" -c;
                    break
                    ;;
                Restore,*|*,[rR]estore)
                    _transfuse_users
                    read -rp "Please enter the name of the user to restore configs to: "  PATIENT
                    "$0" -r "$PATIENT";
                    break
                    ;;
                Help,*|*,[hH]elp)
                    "$0" -h;
                    break
                    ;;
                Quit,*|*,[qQ]uit)
                    echo -e "\nExiting now.";
                    break 2
                    ;;
                *) echo "invalid option $REPLY" ;;
            esac
        done;
    done;
fi;

while test $# -gt 0; do

    case "$1" in

        -b|backup|--backup)

            shift
            if test $# -gt 0; then
                YOU="${1//^[^ ]* //g}"
                _transfuse_homechck
                _transfuse_copy
                if [ -z "$COVERED" ]; then
                    mkdir -p ./"$YOU"_transfusion_"$NOW"/.local/share/wallpapers;
                    OLDFLWR=$(awk -F: '/\[Wallpaper\]\[org\.kde\.image\]/ && $0 != "" { getline; print $1 }' /home/"$YOU"/.config/plasma-org.kde.plasma.desktop-appletsrc | awk '{ sub(/(Image=){1}/, "") }1 && !/^file$/')
                    AROSE=$(basename -- "$OLDFLWR")
                    PETAL="${AROSE##*.}"
                    rsync -rltD --ignore-missing-args "$OLDFLWR" ./"$YOU"_transfusion_"$NOW"/.local/share/wallpapers;
                    cp -r "$OLDFLWR" ./"$YOU"_transfusion_"$NOW"/.local/share/wallpapers/flowers."$PETAL";
                else
                    echo -e '\n You are "Covered", meaning no wallpaper was copied.\n That, or there was an error, in which case yell at cscs.';
                fi;
                if [[ $CHARTS -eq 1 ]];
                then
                    tar -zcvf ./"$YOU"_transfusion_"$NOW".tar.gz ./"$YOU"_transfusion_"$NOW";
                else
                    {
                        tar -zcvf ./"$YOU"_transfusion_"$NOW".tar.gz ./"$YOU"_transfusion_"$NOW";
                    } &> /dev/null;
                fi;
                rm -rf ./"$YOU"_transfusion_"$NOW";
                echo -e "\nWe copied and compressed items recursively from:\n\n~\n~/.config\n~/.local/share\n\nThe compressed backup is timestamped and named ""$YOU""_transfusion_""$NOW"".tar.gz\n" ;
            else
                _transfuse_confused
                exit;
            fi;
            shift ;; # backup (copy+compress) large group

        -bt|backuptopical|--backupt)

            shift
            if test $# -gt 0; then
                YOU="${1//^[^ ]* //g}"
                _transfuse_homechck
                _transfuse_copa
                _transfuse_copt
                if [[ $CHARTS -eq 1 ]];
                then
                    tar -zcvf ./"$YOU"_transfusion_T-"$NOW".tar.gz ./"$YOU"_transfusion_"$NOW";
                else
                    {
                        tar -zcvf ./"$YOU"_transfusion_T-"$NOW".tar.gz ./"$YOU"_transfusion_"$NOW";
                    } &> /dev/null;
                fi;
                rm -rf ./"$YOU"_transfusion_"$NOW";
                echo -e "\nWe copied and compressed items recursively from:\n\n~\n~/.config\n~/.local/share\n\nThe compressed backup is timestamped and named ""$YOU""_transfusion_T-""$NOW"".tar.gz" ;
                echo -e "\nThis is a 'topical' backup. Only the minimum of themes and aesthetics are saved.\n"
            else
                _transfuse_confused
                exit;
            fi;
            shift ;; # backup (copy+compress) appearances group

        -BR|backuproot|--backuproot)

            if test $# -gt 0; then
                mkdir -p ./root_transfusion_"$NOW";
                mkdir -p ./root_transfusion_"$NOW"/usr/share;
                rsync -av --ignore-missing-args /usr/share/aurorae ./root_transfusion_"$NOW"/usr/share/;
                rsync -av --ignore-missing-args /usr/share/color-schemes ./root_transfusion_"$NOW"/usr/share/;
                rsync -av --ignore-missing-args /usr/share/fonts ./root_transfusion_"$NOW"/usr/share/;
                rsync -av --ignore-missing-args /usr/share/gtk* ./root_transfusion_"$NOW"/usr/share/;
                rsync -av --ignore-missing-args /usr/share/icons ./root_transfusion_"$NOW"/usr/share/;
                rsync -av --ignore-missing-args /usr/share/KDE ./root_transfusion_"$NOW"/usr/share/;
                rsync -av --ignore-missing-args /usr/share/kde-gtk-config ./root_transfusion_"$NOW"/usr/share/;
                rsync -av --ignore-missing-args /usr/share/kde4 ./root_transfusion_"$NOW"/usr/share/;
                rsync -av --ignore-missing-args /usr/share/konsole ./root_transfusion_"$NOW"/usr/share/;
                rsync -av --ignore-missing-args /usr/share/Kvantum ./root_transfusion_"$NOW"/usr/share/;
                rsync -av --ignore-missing-args /usr/share/plasma ./root_transfusion_"$NOW"/usr/share/;
                rsync -av --ignore-missing-args /usr/share/sddm ./root_transfusion_"$NOW"/usr/share/;
                rsync -av --ignore-missing-args /usr/share/themes ./root_transfusion_"$NOW"/usr/share/;
                rsync -av --ignore-missing-args /usr/share/wallpapers ./root_transfusion_"$NOW"/usr/share/;
                if [[ $CHARTS -eq 1 ]];
                then
                    tar -zcvf ./root_transfusion_"$NOW".tar.gz ./root_transfusion_"$NOW";
                else
                    {
                        tar -zcvf ./root_transfusion_"$NOW".tar.gz ./root_transfusion_"$NOW";
                    } &> /dev/null;
                fi;
                rm -rf ./root_transfusion_"$NOW";
                echo -e "\n\nWe copied and compressed items recursively from:\n\n/usr/share/\n\nThe compressed backup is named root_transfusion_""$NOW"".tar.gz\n";
            else
                _transfuse_confused
                exit;
            fi;
            exit ;; # backup (copy+compress) root group

        -C|copy|--copy)

            shift
            if test $# -gt 0; then
                YOU="${1//^[^ ]* //g}"
                _transfuse_homechck
                {
                    _transfuse_copy
                } &> /dev/null;
                echo -e "\n\nWe copied items recursively from:\n\n~\n~/.config\n~/.local/share\n\nThe new directory is timestamped and named ""$YOU""_transfusion_""$NOW""\n" ;
            else
                _transfuse_confused
                exit;
            fi;
            shift ;; # copy large group

        -c|compress|--compress)

            echo -e "\nPlease select a copy to compress.\n";
            unset options i
            while IFS= read -r -d $'\0' f; do
                options[i++]="$f"
            done < <(find . -maxdepth 1 -type d -name "*_transfusion_*" -print0 )
            select opt in "${options[@]}" "Cancel"; do
                case $opt in
                    *_transfusion_*)
                        if [[ $CHARTS -eq 1 ]];
                        then
                            tar -zcvf "${opt}.tar.gz" "$opt";
                        else
                            {
                                tar -zcvf "${opt}.tar.gz" "$opt";
                            } &> /dev/null;
                        fi;
                        echo -e "\nCompressed items recursively from:\n\n""$opt""\n";
                        break
                        ;;
                    "Cancel")
                        echo -e "\nCancelled.\n";
                        break
                        ;;
                    *)
                        echo "Invalid selection.";
                        ;;
                esac
            done
            exit ;; # compress an uncompressed copy

        -h|help|--help)

            echo "$HELP" ;
            exit ;;

        -p|pkglists|--pkglists)

            pacman -Qqen > ./"$HOSTNAME"_"$NOW"_native.txt;
            pacman -Qqem > ./"$HOSTNAME"_"$NOW"_alien.txt;
            echo -e "\n Package lists created for 'native' and 'alien' packages and prefixed with '""$HOSTNAME""_""$NOW""'\n";
            exit ;; # create package lists for use with ALPM

        -pr|pkgrestore|--pkgrestore)

            echo -e "\nPlease select a package list to restore.\n";
            unset options i
            while IFS= read -r -d $'\0' f; do
                options[i++]="$f"
            done < <(find . -maxdepth 1 -type f -name "*native.txt" -print0 )
            select opt in "${options[@]}" "Cancel"; do
                case $opt in
                    *native.txt)
                        echo -e "\nPackage list ""$opt"" selected.\n";
                        sudo pacman -S --needed - < "$opt";
                        break
                        ;;
                    "Cancel")
                        echo -e "\nCancelled.\n";
                        break
                        ;;
                    *)
                        echo "Invalid selection.";
                        ;;
                esac
                if [ ! -f "$opt" ]; then
                    echo -e "\n No package list selected.\n";
                    exit;
                fi;
            done
            exit ;; # use pacman to install packages from a list

        -pra|pkgrestorealien|--pkgrestorealien)

            echo -e "\nPlease select an alien package list to restore.\n";
            unset options i
            while IFS= read -r -d $'\0' f; do
                options[i++]="$f"
            done < <(find . -maxdepth 1 -type f -name "*_alien.txt" -print0 )
            select opt in "${options[@]}" "Cancel"; do
                case $opt in
                    *_alien.txt)
                        echo -e "\nPackage list ""$opt"" selected.\n";
                        ALIENLIST=$(tr '\n' ' ' < "$opt")
                        if command -v paru >/dev/null 2>&1; then
                            paru -Sa --needed - < "$opt";
                        elif command -v yay >/dev/null 2>&1; then
                            yay -Sa --needed - < "$opt";
                        elif command -v trizen >/dev/null 2>&1; then
                            trizen -Sa --needed - < "$opt";
                        elif command -v pikaur >/dev/null 2>&1; then
                            pikaur -Sa --needed - < "$opt";
                        elif command -v pacaur >/dev/null 2>&1; then
                            pacaur -Sa --needed "$ALIENLIST";
                        elif command -v pamac >/dev/null 2>&1; then
                            pamac build "$ALIENLIST";
                        else
                            echo "Either you have no aur helper or you should yell at cscs.";
                        fi
                        break
                        ;;
                    "Cancel")
                        echo -e "\nCancelled.\n";
                        break
                        ;;
                    *)
                        echo "Invalid selection."
                        ;;
                esac
                if [ ! -f "$opt" ]; then
                    echo -e "\n No package list selected.\n";
                    exit;
                fi;
            done
            exit ;; # use aur helper to install foreign packages from a list

        -r|restore|--restore)

            shift
            if test $# -gt 0; then
                echo -e "\nPlease select a backup to restore.\n";
                unset options i
                while IFS= read -r -d $'\0' f; do
                    options[i++]="$f"
                done < <(find . -maxdepth 1 -type f -name "*.tar.gz" -print0)
                select opt in "${options[@]}" "Cancel"; do
                    case $opt in
                        *.tar.gz)
                            echo -e "\nBackup file $opt selected.";
                            # processing
                            break
                            ;;
                        "Cancel")
                            echo -e "\nCancelled.";
                            break
                            ;;
                        *)
                            echo "Invalid selection.";
                            ;;
                    esac
                done
                PATIENT="${1//^[^ ]* //g}"
                if [ ! -d "/home/$PATIENT" ]; then
                    echo -e "\n Directory /home/$PATIENT does not exist.\n";
                    exit;
                fi;
                if [ ! -f "$opt" ]; then
                    echo -e "\n No Backup selected.\n";
                    exit;
                fi;
                echo " ";
                read -p "Are you sure you would like to restore ""$opt"" to /home/$PATIENT/? (y/N) " -n 1 -r ;
                echo " ";
                if [[ ! $REPLY =~ ^[Yy]$ ]];
                then exit 1;
                fi;
                if [[ $CHARTS -eq 1 ]];
                then
                    mkdir -p -m 777 /tmp/transfusion;
                    tar -xzvf "$opt" -C /tmp/transfusion/;
                    COPYF=/tmp/transfusion/${opt::-7}
                    rsync -rltDii --ignore-missing-args "$COPYF"/ --include=".*" /home/"$PATIENT"/;
                    _transfuse_restore
                else
                    {
                        mkdir -p -m 777 /tmp/transfusion;
                        tar -xzvf "$opt" -C /tmp/transfusion;
                        COPYF=/tmp/transfusion/${opt::-7}
                        rsync -rltD --ignore-missing-args "$COPYF"/ --include=".*" /home/"$PATIENT"/;
                        _transfuse_restore
                    } &> /dev/null ;
                fi;
                if [[ $? -eq "0" ]] ;
                then
                    sleep 0.5;
                    rm -rf "$COPYF" ;
                    echo -e "\nFinished.\n";
                    echo -e "\nPlease log out or restart to finalize the restoration.\n";
                else
                    echo -e "Something went wrong.\nAre you sure you have the proper permissions?\n";
                fi;
            else
                _transfuse_confused
                exit;
            fi;
            shift ;; # restore from compressed backup

        *)
            echo "$HELP";
            break
            ;;

    esac

done

echo

exit
