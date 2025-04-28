FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy all app files
COPY . .

# Install Flask (tiny web server for health check)
RUN pip install flask

# Expose port 8000 (for dummy web server)
EXPOSE 8000

# Health check - check if port 8000 is open
HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD curl --fail http://localhost:8000/ || exit 1

# Start the app
CMD ["python3", "main.py"]
