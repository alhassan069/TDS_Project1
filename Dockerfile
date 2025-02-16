FROM python:3.11-slim

# Install uv.
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Copy the application into the container.
COPY . /app

# Install the application dependencies.
WORKDIR /app

# Install system dependencies for required packages
RUN apt-get update && apt-get install -y \
    git \
    vim \
    npm \
    tesseract-ocr \
    libsqlite3-dev \
    libglib2.0-0 \
    libtesseract-dev \
    && rm -rf /var/lib/apt/lists/*

    
RUN uv sync --frozen --no-cache

RUN npm install --no-cache-dir prettier@3.4.2


# Run the application.
CMD ["/app/.venv/bin/uvicorn", "main:app", "--port", "80", "--host", "0.0.0.0"]