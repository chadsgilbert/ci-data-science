
setup:
	pip install -r requirements.txt
	sudo apt-get update && sudo apt-get install -y pandoc

directory:
	mkdir -p site/

lint:
	pycodestyle *.py

check:
	pytest

generate: directory
	python example_plot.py site/example_plot.png
	pandoc README.md -o site/index.html

