.PHONY: all pdf html

all: pdf html

cvpre.bib cvpub.bib: cv.bib
	python splitpubs.py cv.bib

%.bbl: %.bib askhampubs.bst
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

html: cv1.tex

clean: 
	rm -f *.log
	rm -f *.pdf
	rm -f *.toc
	rm -f *.aux
	rm -f *.bbl
	rm -f cv1.tex
	rm -f *.blg

install: pdf
	cp cv.pdf ~/Dropbox/personal-website/cv/cv.pdf
	cd ~/Dropbox/personal-website/cv; git add cv.pdf; \
	git commit -m "update cv"; git push origin master
