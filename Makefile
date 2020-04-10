
all: site/sir.png \
	site/index.html \
	site/map/pipeline.png \
	site/map/index.html

.PHONY: setup
setup:
	pip install -r requirements.txt
	sudo apt-get update && sudo apt-get install -y asciidoctor 

directory:
	mkdir -p site/ && mkdir -p site/map

lint:
	pycodestyle *.py --ignore=E741

check:
	pytest

site/sir.png: directory lint check sir.py
	python sir.py

site/index.html: directory index.adoc 
	asciidoctor index.adoc -o $@

site/map/pipeline.png: directory Makefile
	makefile2dot <Makefile | dot -Tpng > $@

site/map/index.html: directory map/index.adoc
	asciidoctor map/index.adoc -o $@

.PHONY: clean
clean:
	rm -rf site
