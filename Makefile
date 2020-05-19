
.PHONY: all
all: site

.PHONY: setup
setup:
	pip install -r requirements.txt
	sudo apt-get update && sudo apt-get install -y asciidoctor graphviz
	mkdir -p site

.PHONY: lint
lint: .linted

.linted: sir/sir sir/plot sir/duration sir/total sir/analyse
	pycodestyle $? && touch .linted

.PHONY: check
check: .checked

# TODO: add tests/validation for the simulation. It should be re-validated
# before re-running the analysis.
.checked: sir/sir sir/plot sir/duration sir/total sir/analyse
	touch .checked

sir/case0.h5: sir/sir
	sir/sir simulate $@ --beta 0.05 --gamma 0.00

sir/case1.h5: sir/sir
	sir/sir simulate $@ --beta 0.04 --gamma 0.01

sir/case2.h5: sir/sir
	sir/sir simulate $@ --beta 0.08 --gamma 0.04

site/case0.png: sir/plot sir/case0.h5
	sir/plot sir/case0.h5 $@

site/case1.png: sir/plot sir/case1.h5
	sir/plot sir/case1.h5 $@

site/case2.png: sir/plot sir/case2.h5
	sir/plot sir/case2.h5 $@

sir/batch.h5: sir/sir
	sir/sir batch sir/batch.h5

site/beta_v_gamma.png: sir/analyse sir/batch.h5
	sir/analyse sir/batch.h5 site/beta_v_gamma.png

site/beta_v_gamma_total.png: sir/total sir/batch.h5
	sir/total sir/batch.h5 site/beta_v_gamma_total.png 

site/beta_v_gamma_duration.png: sir/duration sir/batch.h5
	sir/duration sir/batch.h5 site/beta_v_gamma_duration.png

site/index.html: index.adoc
	asciidoctor index.adoc -o $@

.PHONY: site
site: \
	.linted \
	.checked \
	site/index.html \
	site/case0.png \
	site/case1.png \
	site/case2.png \
	site/beta_v_gamma.png \
	site/beta_v_gamma_total.png \
	site/beta_v_gamma_duration.png \
	site/index.html \
	
.PHONY: clean
clean:
	rm -rf site
