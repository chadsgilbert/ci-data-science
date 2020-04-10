
.PHONY: all
all: site/sir.png \
	site/index.html \
	site/map/pipeline.png \
	site/map/index.html

.PHONY: setup
setup:
	pip install -r requirements.txt
	sudo apt-get update && sudo apt-get install -y asciidoctor 

.PHONY: lint
lint: sir/sir
	pycodestyle sir/sir --ignore=E741

.PHONY: check
check: sir/sir
	pytest sir/*

directory:
	mkdir -p site/ && mkdir -p site/map

sir/output.h5: sir/sir
	sir/sir simulate sir/output.h5

site/sir.png: sir/output.h5
	sir/sir plot sir/output.h5

site/index.html: directory index.adoc 
	asciidoctor index.adoc -o $@

site/map/pipeline.png: directory Makefile
	makefile2dot <Makefile | dot -Tpng > $@

site/map/index.html: directory map/index.adoc
	asciidoctor map/index.adoc -o $@

.PHONY: clean
clean:
	rm -rf site
