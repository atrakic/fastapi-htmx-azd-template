FROM python:3.8-slim-buster

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

RUN addgroup --system fastapi \
    && adduser --system --ingroup fastapi fastapi

WORKDIR /app
COPY --chown=fastapi:fastapi . ./
RUN pip install --no-cache-dir -r requirements.txt
RUN chmod +x start.sh

EXPOSE 3000
CMD ["/app/start.sh"]
