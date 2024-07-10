FROM python:3.11.1-slim
LABEL maintainer="Admir Trakic <atrakic@users.noreply.github.com>"
WORKDIR /app

# Keeps Python from generating .pyc files in the container
ENV PYTHONDONTWRITEBYTECODE=1

# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

RUN addgroup --system fastapi \
    && adduser --system --ingroup fastapi fastapi

COPY --chown=fastapi:fastapi ./src ./
COPY --chown=fastapi:fastapi ./templates ./templates
COPY --chown=fastapi:fastapi ./requirements.txt ./

RUN pip install --no-cache-dir -r requirements.txt

ARG PORT=3000
ENV PORT=${PORT}
EXPOSE ${PORT}

USER fastapi
CMD ["bash", "-c", "uvicorn main:app --no-server-header --port $PORT --host 0.0.0.0"]
