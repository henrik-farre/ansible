# Base image with shared options
FROM python:3-slim AS python
ENV PYTHONUNBUFFERED=true
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR /app

# Poetry build image
FROM python AS poetry
ENV POETRY_HOME=/opt/poetry
ENV POETRY_VIRTUALENVS_IN_PROJECT=true
ENV POETRY_CACHE_DIR=/tmp/poetry_cache
ENV POETRY_VERSION="2.1.3"
ENV PATH="$POETRY_HOME/bin:$PATH"

COPY ftpserver /app/

RUN python3 -m venv "$POETRY_HOME" \
    && "$POETRY_HOME/bin/pip" install -U pip setuptools \
    && "$POETRY_HOME/bin/pip" install poetry==$POETRY_VERSION

RUN --mount=type=cache,target=$POETRY_CACHE_DIR poetry install --no-interaction --no-ansi

# Final image
FROM python AS runtime
ENV PATH="/app/.venv/bin:$PATH"
ENV USERNAME="ftpserver"

# Create a non-root user
# --no-log-init: https://github.com/hadolint/hadolint/wiki/DL3046
# 1.2 Don’t bind to a specific UID: https://sysdig.com/learn-cloud-native/dockerfile-best-practices/#1-2-dont-bind-to-a-specific-uid
RUN useradd --no-log-init --create-home $USERNAME

COPY --chown=$USERNAME --from=poetry /app /app
RUN chown -R $USERNAME /app

USER $USERNAME

CMD ["ftpserver"]
