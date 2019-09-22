# Pull base image
FROM python:3.6-alpine

ENV PIPENV_VENV_IN_PROJECT=1

# Set work directory
RUN apk update \
  # psycopg2 dependencies
  && apk add --virtual build-deps gcc python3-dev musl-dev py3-virtualenv \
  && apk add postgresql-dev \
  # Pillow dependencies
  && apk add jpeg-dev zlib-dev freetype-dev lcms2-dev openjpeg-dev tiff-dev tk-dev tcl-dev \
  # CFFI dependencies
  && apk add libffi-dev py-cffi git make


# assemble

WORKDIR /app

RUN pip install --upgrade pip
RUN pip install --upgrade pipenv

# run
CMD pipenv install --deploy && pipenv run gunicorn simpledjango.wsgi --bind 0.0.0.0:5000 --chdir=/app

EXPOSE 5000
