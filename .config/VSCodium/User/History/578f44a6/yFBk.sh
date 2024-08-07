#!/bin/sh

if [ "$3" != "" ] && [ "$2" -eq "$2" ] && [ "$3" -eq "$3" ]; then
	sed -i 's/SFX[[:space:]]'"$2"'[[:space:]]/SFX '"$3"'\t/g' langs/"$1"/common-aff.d/*
	find langs/"$1"/rules/ -type f | grep "/aff" | while read -r ruleaff
	do
		sed -i '/[^0-9]'"$2"'[^0-9]/s/'"$2"'/'"$3"'/g' "$ruleaff"
	done
else
	echo "Usage: $0 lang from-rule-number to-rule-number"
fi
