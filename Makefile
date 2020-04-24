
.PHONY: all
all: site

.PHONY: setup
setup:
	pip install -r requirements.txt
	sudo apt-get update && sudo apt-get install -y asciidoctor graphviz
	mkdir -p site

.PHONY: lint
lint: sir/sir
	pycodestyle sir/sir --ignore=E741

.PHONY: check
check: sir/sir

sir/case0.h5: sir/sir
	sir/sir simulate $@ --beta 0.05 --gamma 0.00

sir/case1.h5: sir/sir
	sir/sir simulate $@ --beta 0.04 --gamma 0.01

sir/case2.h5: sir/sir
	sir/sir simulate $@ --beta 0.08 --gamma 0.04

site/case0.png: sir/case0.h5
	sir/sir plot sir/case0.h5 $@

site/case1.png: sir/case1.h5
	sir/sir plot sir/case1.h5 $@

site/case2.png: sir/case2.h5
	sir/sir plot sir/case2.h5 $@

sir_results = $(shell printf "sir/batch_%s.h5 " {10..90..10}"_"{10..90..10})
$(sir_results) &: sir/sir
	sir/sir batch sir/batch

site/beta_v_gamma.png: $(sir_results)
	sir/sir analyse sir/batch site/beta_v_gamma.png

site/beta_v_gamma_total.png: $(sir_results)
	sir/sir total sir/batch site/beta_v_gamma_total.png 

site/index.html: index.adoc pipeline.adoc sir.adoc
	asciidoctor index.adoc -o $@

site/pipeline.png: Makefile
	makefile2dot <Makefile | dot -Tpng > $@

site: site/index.html \
	site/case0.png \
	site/case1.png \
	site/case2.png \
	site/beta_v_gamma.png \
	site/beta_v_gamma_total.png \
	site/index.html \
	site/pipeline.png

.PHONY: clean
clean:
	rm -rf site
