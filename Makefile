build:
	for file in article coverletter; do \
		pdflatex $$file.tex; \
		bibtex $$file || true ; \
	done
	mkdir -p assets
	cp *.pdf assets/

clean:
	rm -f *.aux *.log *.out *.toc *.pdf *.blg *.bbl *.bcf *.run.xml

screenshot:
	magick -density 144 "article.pdf[0]" assets/article0.png
	magick -density 144 "coverletter.pdf[0]" assets/coverletter0.png

init_git: build
	rm -rf .git
	git init
	git add .
	git add assets -f
	git commit -m "Initial commit"
	git branch -M main
	git remote add origin git@github.com:intcomp/TempLaTeX
	git push -u origin main -f

.PHONY: build clean init_git
