FROM python:3.8-alpine3.11
LABEL maintainer="smartlab-dev@mpt.mp.br"

ENV PYTHONPATH /app:/usr/lib/python3.8/site-packages

COPY requirements.txt /app/requirements.txt
COPY app/*.py /app/
COPY uwsgi.ini /etc/uwsgi/conf.d/
COPY start.sh /start.sh

ENV MPLLOCALFREETYPE 1

WORKDIR /app

RUN apk --update --no-cache add build-base libffi-dev openssl-dev libffi openssl ca-certificates && \
    apk --update --no-cache add cyrus-sasl-dev libstdc++ gfortran openblas-dev uwsgi && \
    ln -s /usr/include/locale.h /usr/include/xlocale.h && \
    pip3 install -r /app/requirements.txt && \
    apk del build-base libffi-dev openssl-dev libffi openssl ca-certificates && \
    rm -rf /var/cache/apk/* && \
    rm -rf ~/.cache/ && \
    mkdir -p /var/run/flask && \
    apk --no-cache add uwsgi-python3

ENV LANG C.UTF-8
ENV DEBUG 0
ENV FLASK_APP /app/main.py

EXPOSE 5000

ENTRYPOINT ["sh", "/start.sh"]
