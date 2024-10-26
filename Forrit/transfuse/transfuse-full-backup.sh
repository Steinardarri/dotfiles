#!/usr/bin/env zsh

cd /home/steinardth/Forrit/transfuse
./transfuse.sh -b steinardth
./transfuse.sh -p

fd '.*\.[(txt)(tar.*)]' --changed-before 10d -X rm
