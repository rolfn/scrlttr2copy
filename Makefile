
# Rolf Niepraschk, 2016-02-13, Rolf.Niepraschk@gmx.de

.SUFFIXES : .tex .ltx .dvi .ps .pdf .eps

MAIN = letter-copy

VERSION = $(shell awk '/ProvidesFile/ {print $$2}' copy.lco)

DIST_DIR = $(MAIN)

DIST_FILES = copy.lco README.md $(MAIN)-test.tex $(MAIN)-test.pdf

LATEX = pdflatex

ARCHNAME = $(MAIN)-$(VERSION).zip

all : $(MAIN)-test.pdf

$(MAIN)-test.pdf : $(MAIN)-test.tex copy.lco
	$(LATEX) $<
	$(LATEX) $<

debug :
	@echo ">"$(VERSION)"<"
	@echo ">"$(ARCHNAME)"<"

clean :
	$(RM) $(addprefix $(MAIN)-test, .log .aux .bbl .blg)

veryclean : clean
	$(RM) $(MAIN)-test.pdf $(ARCHNAME)

dist : all
	mkdir -p $(DIST_DIR)
	cp -p $(DIST_FILES) $(DIST_DIR)
	rm -f $(ARCHNAME)
	zip $(ARCHNAME) -r $(DIST_DIR)
	rm -rf $(DIST_DIR)


