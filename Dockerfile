# Use a minimal Python base image
FROM python:3.12-slim-bookworm

# Install required system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl ca-certificates git && \
    rm -rf /var/lib/apt/lists/*

# Download and install uv package manager
ADD https://astral.sh/uv/install.sh /uv-installer.sh
RUN sh /uv-installer.sh && rm /uv-installer.sh

# Ensure `uv` binary is on PATH
ENV PATH="/root/.local/bin:$PATH"

# Set environment variable for AI Proxy Token (to be passed at runtime)
ENV AIPROXY_TOKEN=""

# Set up the application directory
WORKDIR /app

# Copy application files
COPY . /app

# Create a virtual environment and install dependencies
# RUN uv venv && uv pip install -r requirements.txt

# Expose port 8000
EXPOSE 8000

# Run the FastAPI app with Uvicorn, binding to all interfaces
CMD ["uv","run","app.py"]
