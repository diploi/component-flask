FROM ghcr.io/astral-sh/uv:bookworm-slim

# This will be set by the GitHub action to the folder containing this component.
ARG FOLDER=/app

# This will be set by the GitHub action if "PYTHON_VERSION" ENV is set in diploi.yaml
ARG PYTHON_VERSION=3.12

RUN mkdir -p /.cache/uv && chown -R 1000:1000 /.cache
RUN mkdir -p /.local/share/uv/python && chown -R 1000:1000 /.local/share/uv

COPY --chown=1000:1000 . /app
WORKDIR ${FOLDER}

ENV UV_COMPILE_BYTECODE=1
ENV UV_LINK_MODE=copy
ENV PATH="$FOLDER/.venv/bin:$PATH"
ENV UV_PYTHON=${PYTHON_VERSION}

USER 1000:1000

RUN uv python install ${PYTHON_VERSION} && \
    uv venv .venv && \
    if [ -f pyproject.toml ]; then \
    uv sync --locked --no-dev || uv sync --no-dev; \
    elif [ -f requirements.txt ]; then \
    uv pip install -r requirements.txt; \
    fi

# Install gunicorn in the virtual environment if it's not already installed
RUN uv pip show --python .venv/bin/python gunicorn >/dev/null 2>&1 || \
    uv pip install --python .venv/bin/python gunicorn --link-mode=copy


CMD ["uv", "run", "--frozen", "gunicorn","-w", "4", "-b", "0.0.0.0:8000", "src.main:app"]