.PHONY: all pdf html

all: pdf html

cvpre.bib cvpub.bib: cv.bib
	python splitpubs.py cv.bib

%.bbl: %.bib
	pdflatex $(patsubst %.bbl,%,$@)
	bibtex $(patsubst %.bbl,%,$@)
	pdflatex $(patsubst %.bbl,%,$@)
	pdflatex $(patsubst %.bbl,%,$@)

cv1.tex: cv1before.tex cv1after.tex cvpre.bbl cvpub.bbl
	@cat cv1before.tex > cv1.tex
	@echo "\section{Publications}" >> cv1.tex
	@echo "" >> cv1.tex
	@echo "\subsection{Journal Articles \& Books}" >> cv1.tex
	@echo "" >> cv1.tex
	@cat cvpub.bbl >> cv1.tex
	@echo "\subsection{Preprints}" >> cv1.tex
	@echo "" >> cv1.tex
	@cat cvpre.bbl >> cv1.tex
	@cat cv1after.tex >> cv1.tex

pdf: cv.tex cv1.tex
	pdflatex cv.tex
	pdflatex cv.tex
