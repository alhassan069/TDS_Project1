FROM python:3.11-slim

# Install uv.
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Copy the application into the container.
COPY . /app

# Install the application dependencies.
WORKDIR /app
RUN uv sync --frozen --no-cache

RUN npm install --no-cache-dir prettier@3.4.2


# Run the application.
CMD ["/app/.venv/bin/uvicorn", "main:app", "--port", "80", "--host", "0.0.0.0"]