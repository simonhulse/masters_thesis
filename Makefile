# Makefile
# Simon Hulse
# simonhulse@protonmail.com
# Last Edited: Wed 27 Nov 2024 03:08:56 PM EST

PDFLATEX = pdflatex -interaction=nonstopmode Report-Body
BIBER = biber Report-Body

all: thesis.pdf clean

thesis.pdf: build/*.tex build/*.bib
	cd build && $(PDFLATEX) && $(BIBER) && $(PDFLATEX) && $(PDFLATEX) && mv Report-Body.pdf ../thesis.pdf

clean:
	ls build/Report-* | grep -xv '.*\(tex\|bib\)' | xargs -r rm
