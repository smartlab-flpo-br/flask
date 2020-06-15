FROM python:3.8.2-slim
LABEL maintainer="smartlab-dev@mpt.mp.br"

# ENV PYTHONPATH /app:/usr/lib/python3.8/site-packages
COPY requirements.txt /app/requirements.txt

RUN apt-get update && \
    apt-get install -y build-essential gcc && \
    pip3 install -r /app/requirements.txt && \
    mkdir -p /var/run/flask && \
    groupadd -r uwsgi && useradd -r -g uwsgi uwsgi && \
    chown -R uwsgi:uwsgi /var/run/flask && \
    apt-get --purge remove -y gcc && \
    apt-get clean

ENV LANG C.UTF-8
ENV DEBUG 0
ENV FLASK_APP /app/main.py

EXPOSE 5000

USER uwsgi:uwsgi

COPY --chown=uwsgi:uwsgi app/*.py /app/
COPY --chown=uwsgi:uwsgi uwsgi.ini /etc/uwsgi/conf.d/
COPY start.sh /start.sh

WORKDIR /app

ENTRYPOINT ["sh", "/start.sh"]
