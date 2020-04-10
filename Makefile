
.PHONY: all
all: site

.PHONY: setup
setup:
	pip install -r requirements.txt
	sudo apt-get update && sudo apt-get install -y asciidoctor graphviz
	mkdir -p site/map

.PHONY: lint
lint: sir/sir
	pycodestyle sir/sir --ignore=E741

.PHONY: check
check: sir/sir

sir/case1.h5: sir/sir
	sir/sir simulate $@ --beta 0.04 --gamma 0.01

sir/case2.h5: sir/sir
	sir/sir simulate $@ --beta 0.08 --gamma 0.04

site/case1.png: sir/case1.h5
	sir/sir plot sir/case1.h5 $@

site/case2.png: sir/case2.h5
	sir/sir plot sir/case2.h5 $@

site/index.html: index.adoc 
	asciidoctor index.adoc -o $@

site/map/pipeline.png: Makefile
	makefile2dot <Makefile | dot -Tpng > $@

site/map/index.html: map/index.adoc
	asciidoctor map/index.adoc -o $@

site: site/index.html \
	site/case1.png \
	site/case2.png \
	site/map/index.html \
	site/map/pipeline.png

.PHONY: clean
clean:
	rm -rf site
