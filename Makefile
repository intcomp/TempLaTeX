TEMPLATES=article coverletter response

build:
	for file in $(TEMPLATES); do \
		latexmk -pdf -output-directory=tmp -jobname=$$file $$file.tex ;\
	done
	mkdir -p assets
	cp tmp/*.pdf assets/

clean:
	rm -f *.aux *.log *.out *.toc *.pdf *.blg *.bbl *.bcf *.run.xml

screenshot:
	mkdir -p assets
	for file in $(TEMPLATES); do \
		convert -density 200 "tmp/$$file.pdf[0]" assets/$$file.png ;\
	done

gitinit: build screenshot
	rm -rf .git
	git init
	git add .
	git add assets -f
	git commit -m "Initial commit"
	git branch -M main
	git remote add origin git@github.com:intcomp/TempLaTeX
	git push -u origin main -f

.PHONY: build clean init_git
