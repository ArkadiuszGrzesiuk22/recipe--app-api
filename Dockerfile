FROM python:3.9-alpine3.13
LABEL maintainer="Bestrecipe.com"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt ./requirements.dev.txt
COPY ./app /app
WORKDIR /app
EXPOSE 8000

ARG DEV=true
RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /tmp/requirements.txt && \
    if [ $DEV = "true" ];\
        then pip install flake8; \
    fi && \    
    rm -rf /tmp &&\

    adduser \
        --disabled-password \
        --no-create-home \
        django-user

ENV PATH=/py/bin:$PATH

USER django-user
