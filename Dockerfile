FROM python:3.8.2-slim
LABEL maintainer="smartlab-dev@mpt.mp.br"

ENV PYTHONPATH /app:/usr/lib/python3.8/site-packages

COPY requirements.txt /app/requirements.txt
COPY app/*.py /app/
COPY uwsgi.ini /etc/uwsgi/conf.d/
COPY start.sh /start.sh

WORKDIR /app

# Moved commented out packages to flask-dataviz
RUN apt-get update && \
    apt-get install -y build-essential uwsgi-plugin-python3 && \
    pip3 install -r /app/requirements.txt && \
    mkdir -p /var/run/flask && \
    apt-get clean

ENV LANG C.UTF-8
ENV DEBUG 0
ENV FLASK_APP /app/main.py

EXPOSE 5000

ENTRYPOINT ["sh", "/start.sh", "uwsgi"]
