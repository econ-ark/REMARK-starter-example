#!/bin/bash
# Reproduce every computational result in this repository.
#
# Installs the exact package versions recorded in uv.lock into .venv, then executes the
# notebook, which saves its figures in figures/. An executed copy of the notebook, with all
# its output, goes to results/; the notebook in the repository is left unchanged. Takes
# about a minute once the packages are installed.
#
# The dashboard is not executed here: it computes no results, only redraws a figure as a
# slider moves.
#
# Requires uv (https://docs.astral.sh/uv/); the Dockerfile and binder/environment.yml
# install it. reproduce_textetc.sh compiles the LaTeX document from the figures.

set -euo pipefail
cd "$(dirname "$0")"

echo "=== REMARK starter example: reproduction started $(date) ==="

uv sync --locked

mkdir -p results
notebook=code/python/REMARK-starter-example.ipynb
echo ""
echo "=== Executing $notebook ==="
uv run --locked jupyter nbconvert --to notebook --execute \
    --ExecutePreprocessor.kernel_name=python3 \
    --output-dir results "$notebook"

echo ""
echo "=== Reproduction completed $(date) ==="
