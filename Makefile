
all:
	@echo "    setup - install software dependencies"
	@echo "    directory - create the site directory"
	@echo "    lint - run the linter"
	@echo "    check - run the tests"
	@echo "    generate - generate the graphics and document"

setup:
	pip install -r requirements.txt
	sudo apt-get update && sudo apt-get install -y asciidoctor 

directory:
	mkdir -p site/

lint:
	pycodestyle *.py

check:
	pytest

generate: directory
	python example_plot.py site/example_plot.png
	asciidoctor index.adoc -o site/index.html

