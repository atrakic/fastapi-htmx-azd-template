ARG BASE_IMAGE_TAG=3.9.12-alpine
ARG BASE_IMAGE=python

FROM ${BASE_IMAGE}:${BASE_IMAGE_TAG} as builder
RUN apk update && apk add musl-dev libpq-dev gcc

RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# upgrade pip
RUN pip install --upgrade pip

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

##
FROM ${BASE_IMAGE}:${BASE_IMAGE_TAG} as final
RUN apk update && apk add libpq-dev curl bash

RUN addgroup --system fastapi \
    && adduser --system --ingroup fastapi fastapi

COPY --chown=fastapi:fastapi --from=builder /opt/venv /opt/venv
ENV PYTHONDONTWRITEBYTECODE=1 \
  PYTHONUNBUFFERED=1 \
  PATH="/opt/venv/bin:$PATH"

WORKDIR /app
COPY --chown=fastapi:fastapi . ./
RUN chmod +x start.sh
EXPOSE 3000
USER fastapi
CMD ["/app/start.sh"]
