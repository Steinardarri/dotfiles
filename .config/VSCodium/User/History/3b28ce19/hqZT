TH_GEN_IDX = ./th_gen_idx.pl

## Choose either latest article dump of mirror or manually get latest ##

# LATEST := $(shell curl 'https://mirror.accum.se/mirror/wikimedia.org/dumps/iswiktionary/' | grep -oP '[0-9]{8}' | tail -n1)

# latest link: https://dumps.wikimedia.org/iswiktionary/latest/iswiktionary-latest-pages-articles.xml.bz2
LATEST = latest

.PHONY: all clean check check-rules check-thes packages

all: dicts/is.dic dicts/is.aff dicts/th_is.dat dicts/th_is.idx

dependencies:
	apt-get install bzip2 gawk bash ed coreutils make wget hunspell libmythes-dev git python3.12
	python -m ensurepip --upgrade
	locale-gen is_IS.UTF-8
	LC_ALL=is_IS.utf8
	pip install mwparserfromhell tqdm

clean:
	rm -f dicts/is.aff dicts/is.dic dicts/th_is.dat dicts/th_is.idx dicts/is.oxt dicts/is.xpi
	rm -f wiktionary.dic wiktionary.aff wordlist.diff
	rm -f huntest.aff huntest.dic
	rm -f iswiktionary-*-pages-articles.*
	rm -rf libreoffice-tmp/ mozilla-tmp/
	rm -rf dicts/

check: check-rules check-thes check-morph

check-rules:
	echo "Testing old rules..."
	find langs/is/rules/* -type d | while read i; \
	do \
	  cat langs/is/common-aff.d/*.aff > huntest.aff; \
	  if [ -f "$$i/aff" ]; then \
	    LINECOUNT="`grep -ce '^.' "$$i/aff"`"; \
	    echo "SFX X N $$LINECOUNT" >> huntest.aff; \
	    cat "$$i/aff" >> huntest.aff; \
	  fi; \
	  TESTNAME="`basename "$$i"`"; \
	  echo "Testing rule $$TESTNAME"; \
	  cp "$$i/dic" huntest.dic; \
	  test -z "`hunspell -l -d huntest < "$$i/good"`" || { echo "Good word test for $$TESTNAME failed: `hunspell -l -d huntest < "$$i/good"`"; exit 1; }; \
	  test -z "`hunspell -G -d huntest < "$$i/bad"`" || { echo "Bad word test for $$TESTNAME failed: `hunspell -G -d huntest < "$$i/bad"`"; exit 1; }; \
	done
	echo "Testing new rules..."
	test -z "`hunspell -l -d wiktionary < "langs/is/test.good"`" || { echo "Good word test failed: `hunspell -l -d wiktionary < "langs/is/test.good"`"; exit 1; };
	test -z "`hunspell -G -d wiktionary < "langs/is/test.bad"`" || { echo "Bad word test failed: `hunspell -G -d wiktionary < "langs/is/test.bad"`"; exit 1; };
	echo "All passed."

check-thes: dicts/th_is.dat
	! grep ")," $< # pipe, not comma, should separate meanings
	! grep "|[^\(]*)" $< # don't replace comma with pipe inside parentheses
	! grep -P "\xe2" $<
	! grep "([^)]\+(" $<
	! grep "<.*>" $< # no html-like tags
	! grep "&lt;.*&gt;" $< # no html-like tags (encoded)
	@echo "Thesaurus tests passed."

check-morph: dicts/is.dic dicts/is.aff
	@echo "  morphology..."
	@test -z "`hunspell -m -d dicts/is < langs/is/test.good | diff -q langs/is/test.morph -`" || { echo "Morphology test failed: `hunspell -m -d dicts/is < langs/is/test.good | diff langs/is/test.morph -`"; exit 1; };
	@echo "Morphology tests passed."

dicts/is.aff: makedict.sh makedict.py iswiktionary-$(LATEST)-pages-articles.xml.texts iswiktionary-$(LATEST)-pages-articles.xml \
		$(wildcard langs/is/common-aff.d/*) $(wildcard "langs/is/rules/*/*")
	@echo "=== .aff ==="
	./$< is $(LATEST)

dicts/is.dic: makedict.sh makedict.py iswiktionary-$(LATEST)-pages-articles.xml.texts iswiktionary-$(LATEST)-pages-articles.xml \
    $(wildcard langs/is/common-aff.d/*) $(wildcard "langs/is/rules/*/*")
	@echo "=== .dic ==="
	./$< is $(LATEST)

dicts/th_%.dat: makethes.awk %wiktionary-$(LATEST)-pages-articles.xml sortthes.py
	LC_ALL=is_IS.utf8 gawk -F " " -f $< <iswiktionary-$(LATEST)-pages-articles.xml | LC_ALL=is_IS.utf8 ./sortthes.py > $@

%.idx: %.dat
	LC_ALL=is_IS.utf8 cat $< | ${TH_GEN_IDX} > $@

iswiktionary-$(LATEST)-pages-articles.xml.bz2:
	@echo "=== Downloading iswiktionary-$(LATEST)-pages-articles.xml.bz2 ==="
	curl 'https://saimei.ftp.acc.umu.se/mirror/wikimedia.org/dumps/iswiktionary/$(LATEST)/$@' -o $@
	touch $@

iswiktionary-$(LATEST)-pages-articles.xml: iswiktionary-$(LATEST)-pages-articles.xml.bz2
	@echo "=== Unzipping ==="
	bunzip2 -kf $<
	touch $@

iswiktionary-$(LATEST)-pages-articles.xml.texts: iswiktionary-$(LATEST)-pages-articles.xml
	@echo "=== Extracting texts ==="
	tr -d "\r\n" < iswiktionary-$(LATEST)-pages-articles.xml | grep -o "{{[^.|{}]*|[^-.}][^ }]*[}|][^}]*" | sed "s/mynd=.*//g" | sed "s/lo.nf.et.ó=.*//g" | sort | uniq > $@

# Performance test target: perf.txt
randwordlist:
	tr -cd '[:alpha:]' < /dev/urandom | fold -w12 | head -n 100 > randwordlist
	time=/usr/bin/time -o perf.txt -f "%E real\t%U user\t%S sys\t%M mem\t%C" --append
perf.txt: dicts/is.dic dicts/is.aff randwordlist
	hunspell -vv > perf.txt
	${time} hunspell -d dicts/is -a langs/is/wordlist > /dev/null
	${time} hunspell -d dicts/is -a randwordlist      > /dev/null
	${time} hunspell -d dicts/is -m langs/is/wordlist > /dev/null
	${time} hunspell -d dicts/is -m randwordlist      > /dev/null
	${time} hunspell -d dicts/is -s langs/is/wordlist > /dev/null
	${time} hunspell -d dicts/is -s randwordlist      > /dev/null
	@cat perf.txt
