
directory:
	mkdir -p build/

check:
	pytest

generate: directory
	python example_plot.py build/example_plot.png
	pandoc README.md -o build/index.html

