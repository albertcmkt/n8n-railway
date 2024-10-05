FROM n8nio/n8n:1.61.0

ARG N8N_VERSION=0.228.2

RUN apk add --update graphicsmagick tzdata

USER root

ARG ENCRYPTIONKEY
ENV N8N_ENCRYPTION_KEY=$ENCRYPTIONKEY

RUN apk --update add --virtual build-dependencies python3 build-base && \
    npm_config_user=root npm install --location=global n8n@${N8N_VERSION} && \
    apk del build-dependencies

WORKDIR /data

EXPOSE $PORT

ENV N8N_USER_ID=root

CMD export N8N_PORT=$PORT && n8n start
