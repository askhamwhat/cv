.PHONY: all pdf html

all: pdf html

cvpre.bib cvpub.bib: cv.bib
	python splitpubs.py cv.bib

%.bbl: %.bib cv.bst
	pdflatex $(patsubst %.bbl,%,$@)
	bibtex $(patsubst %.bbl,%,$@)
	pdflatex $(patsubst %.bbl,%,$@)
	pdflatex $(patsubst %.bbl,%,$@)

cv1.tex: cv1before.tex cv1after.tex cvpre.bbl cvpub.bbl cv.bib
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
	pandoc -s cv1.tex -o cv.html
	python cvhtml.py cv.html

clean: 
	rm -f *.log *.toc *.aux *.bbl *.blg *~ *#
	rm -f cv1.tex cvpre.bib cvpub.bib cvpre.bbl cvpub.bbl
	rm -f cv.pdf cvpre.pdf cvpub.pdf cv.html index.md

install: pdf html
	cp cv.pdf ~/Dropbox/personal-website/cv/cv.pdf
	cp index.md ~/Dropbox/personal-website/cv/index.md
	cd ~/Dropbox/personal-website/cv; git add cv.pdf; \
	git add index.md; git commit -m "update cv"; \
	git push origin master
