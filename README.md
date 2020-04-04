# Reproducible Research with GitHub Pages

It is important to be able to reproduce the results of a simulation precisely.
This repository demonstrates how this can be done using Asciidoc for text,
python to generate graphics and tables, GNU Make to coordinate the execution,
Git to track the history, GitHub to store and manage the content, Travis CI to 
automate reproduction of the document, and GitHub Pages to host the reuslt.

## Running Locally

You can produce the document locally by running the Makefile. The result will be
placed in a subdirectory called `site`. The `Makefile` assumes you are running
python 3.7 on a Ubuntu 18.04 Bionic Beaver. However, it the same dependencies
can be installed in a different environment. As long as GNU Make, python 3.7 and
asciidoctor are installed, you should be able to run this locally.

## Deploying

Commits to master automatically trigger a new deploy once pushed to GitHub.
