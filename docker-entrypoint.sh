#!/bin/bash
# Make this an executable file
# chmod +x docker-entrypoint.sh
set -e

echo "Collecting Staticfiles..."
python manage.py collectstatic --no-input

echo "Applying migrations..."
python manage.py migrate --no-input

# Development
echo "Starting Gunicorn with ASGI (Uvicorn Worker)..."
exec uvicorn config.asgi:application --host 0.0.0.0 --port 8000 --reload

# Production
# echo "Starting Gunicorn with ASGI (Uvicorn Worker)..."
# exec gunicorn config.asgi:application -k uvicorn.workers.UvicornWorker --bind 0.0.0.0:8000
