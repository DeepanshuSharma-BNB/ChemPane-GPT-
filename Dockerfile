FROM python:3.13-slim AS source
RUN apt-get update && apt-get install -y --no-install-recommends git ca-certificates && rm -rf /var/lib/apt/lists/*
RUN git init /upstream && git -C /upstream remote add origin https://github.com/chempane/chempane.git && git -C /upstream fetch --depth=1 origin ad83eee349762f52dcfa7cafec2a5719a07d327d && git -C /upstream checkout --detach FETCH_HEAD && rm -rf /upstream/.git
FROM python:3.13-slim
ENV PYTHONDONTWRITEBYTECODE=1 PYTHONUNBUFFERED=1 CHEMPANE_REMOTE_HOST=0.0.0.0 CHEMPANE_REMOTE_PORT=8080 JAVA_TOOL_OPTIONS="-Xmx96m"
RUN mkdir -p /usr/share/man/man1 && apt-get update && apt-get install -y --no-install-recommends default-jre-headless && rm -rf /var/lib/apt/lists/* && useradd --create-home --shell /usr/sbin/nologin chempane
WORKDIR /app
COPY --from=ghcr.io/astral-sh/uv:0.11.11 /uv /usr/local/bin/uv
COPY --from=source /upstream /app
RUN uv sync --frozen --no-dev
USER chempane
EXPOSE 8080
HEALTHCHECK --interval=30s --timeout=5s --start-period=30s CMD .venv/bin/python -c "import urllib.request; urllib.request.urlopen('http://127.0.0.1:8080/healthz', timeout=3)"
CMD [".venv/bin/python", "-m", "chempane.remote"]
