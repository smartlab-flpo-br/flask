FROM python:3.8.2-alpine3.11
LABEL maintainer="smartlab-dev@mpt.mp.br"

ENV PYTHONPATH /app:/usr/lib/python3.8/site-packages

COPY requirements.txt /app/requirements.txt
COPY app/*.py /app/
COPY uwsgi.ini /etc/uwsgi/conf.d/
COPY start.sh /start.sh

WORKDIR /app

# Moved commented out packages to flask-dataviz
# RUN apk --update --no-cache add build-base libffi-dev openssl-dev libffi openssl ca-certificates uwsgi && \
#     apk --update --no-cache add cyrus-sasl-dev libstdc++ gfortran openblas-dev uwsgi && \
RUN apk --update --no-cache add build-base libffi-dev uwsgi && \
    pip3 install -r /app/requirements.txt && \
#    apk del build-base libffi-dev openssl-dev libffi openssl ca-certificates && \
    apk del build-base libffi-dev && \
    rm -rf /var/cache/apk/* && \
    rm -rf ~/.cache/ && \
    mkdir -p /var/run/flask
# Removed - seems unnecessary (test without it passed)
#RUN apk --no-cache add uwsgi-python3

ENV LANG C.UTF-8
ENV DEBUG 0
ENV FLASK_APP /app/main.py

EXPOSE 5000

ENTRYPOINT ["sh", "/start.sh"]
