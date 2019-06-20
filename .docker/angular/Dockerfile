FROM node:10

RUN npm install -g typescript

RUN npm install -g @angular/cli

RUN npm install --global gulp-cli

RUN apt-get update && apt-get install -y vim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends chromium

WORKDIR /app

VOLUME ["/app"]
