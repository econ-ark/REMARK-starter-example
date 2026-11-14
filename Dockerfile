# REMARK starter example
#
#   docker build -t remark-starter-example .
#   docker run --rm --user "$(id -u):$(id -g)" \
#       -v "$PWD/results:/app/results" -v "$PWD/figures:/app/figures" remark-starter-example
#
# Running the image executes reproduce.sh. The two mounts put the executed notebook and
# the figures in this folder; --user makes the files yours rather than root's.
# The Python packages are the versions pinned in uv.lock.

FROM python:3.14.10-slim-trixie@sha256:9aaa474097d094040649f2162a627c0049b408f52138d980916788d80f04802f

COPY --from=ghcr.io/astral-sh/uv:0.13.6@sha256:af22a52f5eafef3d78e551599d405c02df61919d18028f0cea8eda93bc9986d0 /uv /uvx /usr/local/bin/

# Use the image's Python, never a downloaded one. HOME=/tmp gives any user, including
# the one --user names, somewhere to write caches and settings.
ENV UV_PYTHON_DOWNLOADS=never \
    UV_LINK_MODE=copy \
    HOME=/tmp

WORKDIR /app

# Install the packages first, so that editing the code does not reinstall them
COPY pyproject.toml uv.lock .python-version ./
RUN uv sync --locked --no-cache && chmod -R a+rwX /app

COPY . .
# reproduce.sh writes into these two folders, as whichever user runs it
RUN mkdir -p results && chmod -R a+rwX results figures

CMD ["./reproduce.sh"]
