
# Rolf Niepraschk, 2016-02-13, Rolf.Niepraschk@gmx.de

.SUFFIXES : .tex .ltx .dvi .ps .pdf .eps

MAIN = letter-copy

VERSION = $(shell awk '/ProvidesFile/ {print $$2}' copy.lco)

DIST_DIR1 = $(MAIN)
DIST_DIR2 = $(MAIN)/doc

DIST_FILES1 = copy.lco
DIST_FILES2 = README.md $(MAIN)-test.pdf result-picture.pdf

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
	mkdir -p $(DIST_DIR1)
	mkdir -p $(DIST_DIR2)
	cp -p $(DIST_FILES1) $(DIST_DIR1)
	cp -p $(DIST_FILES2) $(DIST_DIR2)
	rm -f $(ARCHNAME)
	zip $(ARCHNAME) -r $(DIST_DIR1)
	rm -rf $(DIST_DIR1)


