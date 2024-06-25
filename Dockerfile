#FROM python:3.12.2-slim-bullseye
#LABEL maintainer="londdonappdeveloper.com"
#
#ENV PYTHONUNBUFFERED 1
#
#COPY ./requirements.txt /tmp/requirements.txt
#COPY ./requirements.dev.txt /tmp/requirements.dev.txt
#
#COPY ./app /app
#WORKDIR /app
#EXPOSE 8000
#
#ARG DEV=false
#RUN python -m venv /py && \
#    /py/bin/pip install --upgrade pip && \
#    apk add --update --no-cache postgresql-client && \
#    apk add --update --no-cache --virtual .tmp-build-deps \
#      build-base postgresql-dev musl-dev && \
#    /py/bin/pip install -r /tmp/requirements.txt && \
#    if [ "$DEV" = "true" ]; \
#    then /py/bin/pip install -r /tmp/requirements.dev.txt; \
#    fi && \
#    rm -rf /tmp && \
#    apk del .tmp-build-deps && \
#    adduser \
#        --disabled-password \
#        --no-create-home \
#        django-user
#
#ENV PATH="/py/bin:$PATH"
#
#USER django-user
#
#CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]

FROM python:3.12.2-slim-bullseye
LABEL maintainer="londdonappdeveloper.com"

ENV PYTHONUNBUFFERED=1
ENV PATH="/py/bin:$PATH"

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt

COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=false

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        postgresql-client \
        build-essential \
        libpq-dev \
        gcc \
        && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ "$DEV" = "true" ]; then /py/bin/pip install -r /tmp/requirements.dev.txt; fi && \
    apt-get remove -y gcc && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER nobody

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
