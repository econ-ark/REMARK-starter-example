#!/bin/bash
# Compile the LaTeX document REMARK-starter-example.tex into latex/REMARK-starter-example.pdf,
# with the figures that reproduce.sh saves in figures/.
#
# Requires a LaTeX installation (pdflatex and bibtex), which the Docker image does not have.

set -euo pipefail
cd "$(dirname "$0")"

pdflatex -interaction=nonstopmode -output-directory=latex REMARK-starter-example.tex
bibtex latex/REMARK-starter-example
pdflatex -interaction=nonstopmode -output-directory=latex REMARK-starter-example.tex
pdflatex -interaction=nonstopmode -output-directory=latex REMARK-starter-example.tex
