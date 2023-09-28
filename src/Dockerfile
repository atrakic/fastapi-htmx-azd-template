FROM python:3.11.1-slim
LABEL maintainer="Admir Trakic <atrakic@users.noreply.github.com>"
WORKDIR /app

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

RUN addgroup --system fastapi \
    && adduser --system --ingroup fastapi fastapi

COPY --chown=fastapi:fastapi . ./
RUN pip install --no-cache-dir -r requirements.txt
RUN chmod +x start.sh

USER fastapi
EXPOSE 3000
CMD ["/app/start.sh"]
