# DEV-DATAHUBAPI........: Flask, Pandas, pyLint and Nose
# Version...............: 0.1

FROM alpine:3.7
LABEL maintainer="charles.santosd@mpt.mp.br"

COPY start.sh /start.sh
COPY requirements.txt /app/requirements.txt

RUN apk --update --no-cache add build-base libffi-dev openssl-dev python3-dev libffi openssl ca-certificates python3 cyrus-sasl-dev && \
    pip3 install --upgrade pip setuptools && \
    pip3 install -r /app/requirements.txt && \
    apk del build-base libffi-dev openssl-dev python3-dev libffi openssl ca-certificates && \
    rm -rf /var/cache/apk/* && \
    rm -rf ~/.cache/ && \
    addgroup -g 1000 -S mpt && \
    adduser -u 1000 -S mpt -G mpt && \
    mkdir -p /var/run/flask && \
    chown -R mpt /var/run/flask && \
    chown mpt /app  

ENV LANG C.UTF-8
ENV PYTHONPATH $PYTHONPATH:/app
USER mpt
EXPOSE 5000
WORKDIR /app
ENTRYPOINT ["sh", "/start.sh"]
