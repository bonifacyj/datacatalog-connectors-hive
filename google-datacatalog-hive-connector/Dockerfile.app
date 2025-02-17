# docker build -t hive2datacatalog .
FROM python:3.7

# Copy the local client library dependency and install it (temporary).
WORKDIR /lib

RUN pip install google-cloud-logging

# Install production dependencies.
RUN pip install Flask gunicorn

WORKDIR /app

# Copy project files (see .dockerignore).
COPY . .

# Install hive2datacatalog package from source files.
RUN pip install .

CMD exec gunicorn --log-level=DEBUG --config gunicorn_config.py app:app
