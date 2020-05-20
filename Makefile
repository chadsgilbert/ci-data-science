
.PHONY: all
all: site

.PHONY: setup
CONDA_HOME=https://repo.continuum.io/miniconda
setup:
	sudo apt-get install asciidoctor
	if ! hash conda 2> /dev/null; then \
	    wget $(CONDA_HOME)/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh; \
	    bash miniconda.sh -b -p $HOME/miniconda; \
	    source "$HOME/miniconda3/etc/profile.d/conda.sh"; \
	fi
	conda config --set always_yes yes --set changeps1 no
	conda update -q conda
	conda info -a
	conda env create -f environment.yml
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

case0.h5: sir/sir
	sir/sir simulate $@ --beta 0.05 --gamma 0.00

case1.h5: sir/sir
	sir/sir simulate $@ --beta 0.04 --gamma 0.01

case2.h5: sir/sir
	sir/sir simulate $@ --beta 0.08 --gamma 0.04

site/case0.png: sir/plot case0.h5
	sir/plot case0.h5 $@

site/case1.png: sir/plot case1.h5
	sir/plot case1.h5 $@

site/case2.png: sir/plot case2.h5
	sir/plot case2.h5 $@

batch.h5: sir/sir
	sir/sir batch batch.h5

site/beta_v_gamma.png: sir/analyse batch.h5
	sir/analyse batch.h5 site/beta_v_gamma.png

site/beta_v_gamma_total.png: sir/total batch.h5
	sir/total batch.h5 site/beta_v_gamma_total.png 

site/beta_v_gamma_duration.png: sir/duration batch.h5
	sir/duration batch.h5 site/beta_v_gamma_duration.png

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
