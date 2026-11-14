# REMARK Starter Example

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/econ-ark/REMARK-starter-example/HEAD?labpath=code%2Fpython%2FREMARK-starter-example.ipynb)
The main notebook on Binder, in JupyterLab.

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/econ-ark/REMARK-starter-example/HEAD?urlpath=voila%2Frender%2Fdashboard%2FREMARK-starter-example-dashboard.ipynb)
The dashboard on Binder, with its code hidden.

A REMARK (R[eplications/eproductions] and Explorations Made using ARK) is a self-contained
project whose computational results anyone can reproduce, on any platform, now and years
from now. REMARKs are listed in the [REMARK catalog](https://github.com/econ-ark/REMARK) and
shown on [econ-ark.org](https://econ-ark.org/materials/?select=REMARK).

This repository is a small but complete REMARK, meant to be copied when you start your own.
It meets **Tier 2 (Reproducible REMARK)** of the
[REMARK Standard](https://github.com/econ-ark/REMARK/blob/main/STANDARD.md). For a REMARK
that is a whole paper, see [BufferStockTheory](https://github.com/econ-ark/BufferStockTheory).

## What it computes

- `code/python/REMARK-starter-example.ipynb` solves a consumption-saving model with HARK's
  `KinkyPrefConsumerType`: a consumer with shocks to their preferences, who pays a higher
  interest rate when borrowing than they earn when saving. It draws the consumption function
  at each value of the shock (`figures/cFunc.pdf`).
- The same notebook calls a function in `code/python/custom_code.py` that draws a histogram of
  random numbers (`figures/dist.pdf`). The function takes a seed, so every run draws the same
  numbers.
- `REMARK-starter-example.tex` is a short LaTeX document that includes both figures.
- `dashboard/REMARK-starter-example-dashboard.ipynb` redraws the consumption functions as a
  slider changes the consumer's risk aversion.

## Reproducing the results

`reproduce.sh` regenerates every figure. It installs the exact package versions recorded in
`uv.lock`, then executes the notebook: the figures are written to `figures/`, and an executed
copy of the notebook, with all its output, to `results/`. Once the packages are installed it
takes about a minute. (The dashboard computes no results, so it is left for you to open.)
Use whichever of these suits you.

### With Docker

```bash
docker build -t remark-starter-example .
docker run --rm --user "$(id -u):$(id -g)" \
    -v "$PWD/results:/app/results" -v "$PWD/figures:/app/figures" remark-starter-example
```

The image holds Python and every package; running it runs `reproduce.sh`. The two `-v`
options put the results in this folder, and `--user` makes the files yours rather than
root's. The base image is pinned by its digest, so the image is the same wherever it is built.

### With uv

Install [uv](https://docs.astral.sh/uv/getting-started/installation/), then:

```bash
./reproduce.sh
```

uv installs the Python version named in `.python-version` (if you do not already have it)
and the packages in `uv.lock` into `.venv`. To work with the notebooks yourself, start
JupyterLab with `uv run jupyter lab`, or the dashboard with
`uv run voila dashboard/REMARK-starter-example-dashboard.ipynb`.

### With the REMARK command line tool

The REMARK catalog's `cli.py` builds the environment from `binder/environment.yml` with
[repo2docker](https://repo2docker.readthedocs.io/) and runs `reproduce.sh` in it, which is how
the Econ-ARK team tests a submitted REMARK. In a clone of
[econ-ark/REMARK](https://github.com/econ-ark/REMARK), add a catalog entry
`REMARKs/REMARK-starter-example.yml`:

```yaml
name: REMARK-starter-example
remote: https://github.com/econ-ark/REMARK-starter-example
title: REMARK Starter Example
tag: v1.0.0
```

and run:

```bash
python cli.py pull REMARKs/REMARK-starter-example.yml
python cli.py lint --tier 2 REMARKs/REMARK-starter-example.yml
python cli.py build docker REMARKs/REMARK-starter-example.yml
python cli.py execute docker REMARKs/REMARK-starter-example.yml
```

The [CLI guide](https://econ-ark.github.io/REMARK/cli-guide) explains each command.

### On Binder

The badges at the top open the notebook, or the dashboard, in your browser, with nothing to
install. Binder builds its environment from `binder/`: `environment.yml` installs Python and
uv, and `postBuild` installs the packages in `uv.lock` and makes them the notebooks' kernel.

### The LaTeX document

`reproduce_textetc.sh` compiles `REMARK-starter-example.tex` into
`latex/REMARK-starter-example.pdf` from the figures. It needs a LaTeX installation
(`pdflatex` and `bibtex`), which the Docker image does not include.

## What is in this repository

| File | What it is for | Required |
| --- | --- | --- |
| `reproduce.sh` | Regenerates every result | All tiers |
| `Dockerfile` | Builds an image that runs `reproduce.sh` | All tiers |
| `binder/environment.yml` | The environment the REMARK tool and Binder build | All tiers |
| `pyproject.toml` | The packages the code uses, edited by hand | With uv |
| `uv.lock` | The exact version of every package, written by `uv lock` | All tiers (a lock file) |
| `.python-version` | The exact Python version | With uv |
| `LICENSE` | The terms of use (Apache 2.0) | All tiers |
| `README.md` | This file: at least 50 non-empty lines for Tier 1, 100 for Tier 2 | All tiers |
| `CITATION.cff` | How to cite the REMARK | Tiers 2 and 3 |
| `REMARK.md` | The REMARK's tier, its notebooks and its abstract, for the website | Tiers 2 and 3 |
| `binder/postBuild` | Installs `uv.lock`'s packages on Binder | With uv, for Binder |
| `code/python/` | The notebook, and the module it imports | Yours to organize |
| `dashboard/` | The interactive dashboard | Optional |
| `figures/` | The figures `reproduce.sh` makes | Optional |
| `REMARK-starter-example.tex`, `latex/` | The LaTeX document, its bibliography and the compiled PDF | Optional |
| `reproduce_textetc.sh` | Compiles the LaTeX document | Optional |

Every tier also requires a tagged release; this one is tagged `v1.0.0`. A REMARK whose
`reproduce.sh` takes five minutes or more should also have a `reproduce_min.sh` that
reproduces some of the results quickly. This one is fast enough not to need it.

## Making your own REMARK from this one

1. **Copy the repository.** Clone it, delete its `.git` folder, and push the files to a new
   repository of your own; or use GitHub's "Import repository". Your REMARK stays under your
   account.
2. **Replace the code.** Put your notebooks and code in `code/`, and change `reproduce.sh` so
   that it runs them. Keep it non-interactive: it must run from start to finish with nobody
   at the keyboard, and fail (exit with a nonzero code) if anything goes wrong.
3. **Declare your packages.** Add each one with `uv add <package>` (or edit `pyproject.toml`
   and run `uv lock`), and commit both `pyproject.toml` and `uv.lock`. Change
   `.python-version`, the Dockerfile's base image and `binder/environment.yml` together if
   you need another Python version.
4. **Rename the project** in `pyproject.toml`, `binder/environment.yml`, the Dockerfile's
   comments and `REMARK.md`.
5. **Write your README** with what the REMARK computes and how to reproduce it. The REMARK
   catalog's [templates](https://github.com/econ-ark/REMARK/tree/main/templates) give an
   outline for each tier.
6. **Fill in `CITATION.cff` and `REMARK.md`** with your title, authors, abstract and tier.
   The [CFF initializer](https://citation-file-format.github.io/cff-initializer-javascript/)
   helps write a valid `CITATION.cff`.
7. **Choose a license** and replace `LICENSE` if Apache 2.0 is not the one you want.
8. **Check it.** Run `./reproduce.sh` from a fresh clone, then the REMARK tool's `lint`,
   `build` and `execute` commands above with your own catalog entry.
9. **Tag a release**, for example `git tag -a v1.0.0 -m "First release"` and
   `git push origin v1.0.0`, and release a new tag for each later version.
10. **Submit it** by opening a pull request on the REMARK catalog that adds your entry, as
    [STANDARD.md](https://github.com/econ-ark/REMARK/blob/main/STANDARD.md) describes. For
    Tier 3, get a Zenodo DOI first; the catalog's
    [Zenodo guide](https://econ-ark.github.io/REMARK/zenodo-guide) shows how.

## Keeping results reproducible

- **Pin everything.** `uv.lock` pins every package, including the ones your packages depend
  on; `.python-version` pins Python; the Dockerfile pins its base image by digest. The
  `exclude-newer` date in `pyproject.toml` makes `uv lock` choose the same versions whenever
  it runs; move it forward when you want newer packages.
- **Fix the seed** of every random number generator, as `custom_code.py` does.
- **Leave dates out of output files.** The figures are saved without a creation date, so a
  run that gives the same results writes byte-for-byte the same files.
- **Never edit results by hand.** Everything in `figures/` should come from `reproduce.sh`.

## License and citation

The code and text are released under the Apache License 2.0; see `LICENSE`. To cite this
repository, use `CITATION.cff` (GitHub's "Cite this repository" button reads it).
