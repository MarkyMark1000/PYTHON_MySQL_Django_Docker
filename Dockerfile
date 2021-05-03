FROM python:3.8-alpine

# The enviroment variable ensures that the python output is set straight
# to the terminal with out buffering it first
ENV PYTHONUNBUFFERED 1

# Echo the Environment variables to help with debugging
RUN echo *** $DJANGO_DEBUG *** $MY_ENV ***

EXPOSE 8080

RUN apk update && apk add \
        git openssh \
        libuuid \
        pcre \
        mailcap \
        gcc \
        libc-dev \
        linux-headers \
        pcre-dev \
        tzdata \
    && pip install --no-cache-dir uWSGI \
    && rm -rf /tmp/*

RUN apk add --no-cache --virtual .build-deps mariadb-dev \
    && pip install mysqlclient \
    #&& apk add --no-cache mariadb-client-libs \
    #&& apk del .build-deps \
    && apk del \
        gcc \
        libc-dev \
        linux-headers

RUN mkdir /code

WORKDIR /code

COPY requirements.txt /code/

RUN pip install --no-cache-dir -r requirements.txt

COPY . /code/

RUN python3 manage.py collectstatic --noinput

RUN python3 manage.py makemigrations

RUN python3 manage.py migrate

# Choose which method to use:
ENTRYPOINT python3 /code/manage.py runserver 0.0.0.0:8080
