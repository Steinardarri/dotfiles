#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import sys

terms = {}

sys.stdout.write(sys.stdin.readline())

for line in sys.stdin:
	terms[line] = line
	splitted = line.split('|')
	for i in range(0, int(splitted[1])):
		ml = sys.stdin.readline()
		terms[line] += ml

for k in sorted(terms.keys()):
	sys.stdout.write(terms[k])
