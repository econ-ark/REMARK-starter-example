---
# REMARK metadata (econ-ark/REMARK STANDARD.md) and Econ-ARK website fields
remark-name: REMARK-starter-example
tier: 2
title: "REMARK Starter Example"
github_repo_url: https://github.com/econ-ark/REMARK-starter-example
notebooks:
  - code/python/REMARK-starter-example.ipynb
  - dashboard/REMARK-starter-example-dashboard.ipynb
tags:
  - REMARK
  - Notebook
  - Template
keywords:
  - reproducibility
  - consumption-saving models
  - HARK
---

# Abstract

A small, complete REMARK to copy when starting a new one. Its notebook solves a
consumption-saving model with HARK's `KinkyPrefConsumerType`: a consumer with shocks to
their preferences, who pays a higher interest rate when borrowing than they earn when
saving. It draws the consumption function at each value of the shock. A second figure, a
histogram of random draws made by code kept in a module, shows how to keep results that
depend on random numbers reproducible. A LaTeX document includes both figures, and a
dashboard lets a reader change the consumer's risk aversion with a slider.

Every package version is pinned in `uv.lock`, the Python version in `.python-version`, and
the Docker base image by its digest. `reproduce.sh` regenerates every figure from scratch in
about a minute.

# Using it

The [README](README.md) explains how to reproduce the results with Docker, with uv, with the
REMARK command line tool or on Binder, what each file is for, and how to turn a copy of this
repository into your own REMARK.

The requirements it meets are in the
[REMARK Standard](https://github.com/econ-ark/REMARK/blob/main/STANDARD.md).
