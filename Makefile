
# Rolf Niepraschk, 2020-10-20, Rolf.Niepraschk@gmx.de

.SUFFIXES : .tex .ltx .dvi .ps .pdf .eps

MAIN = scrlttr2copy

VERSION = $(shell awk '/ProvidesFile/ {print $$2}' copy.lco)

DIST_DIR = $(MAIN)

DIST_FILES = copy.lco README.md letter-copy-test.tex 

LATEX = pdflatex

ARCHNAME = $(MAIN)-$(VERSION).zip

all : letter-copy-test.pdf

letter-copy-test.pdf : letter-copy-test.tex copy.lco
	$(LATEX) $<
	$(LATEX) $<

debug :
	@echo ">"$(VERSION)"<"
	@echo ">"$(ARCHNAME)"<"

clean :
	$(RM) $(addprefix letter-copy-test, .log .aux .bbl .blg)

veryclean : clean
	$(RM) letter-copy-test.pdf $(ARCHNAME)

dist : all
	mkdir -p $(DIST_DIR)
	cp -p $(DIST_FILES) $(DIST_DIR)
	rm -f $(ARCHNAME)
	zip $(ARCHNAME) -r $(DIST_DIR)
	rm -rf $(DIST_DIR)


