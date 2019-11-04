FROM alpine:3.7
LABEL maintainer="smartlab-dev@mpt.mp.br"

COPY requirements.txt /app/requirements.txt
COPY app/*.py /app/
COPY uwsgi.ini /etc/uwsgi/conf.d/
COPY start.sh /start.sh

RUN apk --update --no-cache add build-base libffi-dev openssl-dev python3-dev libffi openssl ca-certificates python3 cyrus-sasl-dev libstdc++ uwsgi-python3 gfortran openblas-dev && \
    pip3 install --upgrade pip setuptools && \
    pip3 install -r /app/requirements.txt && \
    apk del build-base libffi-dev openssl-dev python3-dev libffi openssl ca-certificates && \
    rm -rf /var/cache/apk/* && \
    rm -rf ~/.cache/ && \
    mkdir -p /var/run/flask && \
    chown -R uwsgi:uwsgi /var/run/flask /app /etc/uwsgi/conf.d 

ENV LANG C.UTF-8
ENV DEBUG 0
ENV FLASK_APP /app/main.py
ENV PYTHONPATH /app:/usr/lib/python3.6/site-packages

EXPOSE 5000
WORKDIR /app

ENTRYPOINT ["sh", "/start.sh"]
