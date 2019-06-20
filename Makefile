#!make
## Target       Description
#########       ###########

SHELL:=/bin/bash

# defaut template to be used in envfile target
ENVFILE?=.env.default

# Read environment file
ifneq ("$(wildcard .env)","")
	include .env
	export $(shell sed 's/=.*//' .env)
else
	include .docker/env/${ENVFILE}
	export $(shell sed 's/=.*//' .docker/env/$$ENVFILE)
endif

COMPOSE_FILE:=.docker/docker-compose.yml$(if $(LOCAL),:.docker/docker-compose.local.yml,)$(if $(STATIC),:.docker/docker-compose.static-ports.yml,)

DC=docker-compose

DC_RUN=$(DC) run --rm
DC_EXEC=$(DC) exec

export COMPOSE_PROJECT_NAME
export COMPOSE_FILE
export RESTART_POLICY

all: rm up wait-mysql recreate-db

up:
	$(DC) up $(DC_PRM) --force-recreate --remove-orphans --detach
.PHONY: up

env:
	env
.PHONY: env

rm:
	$(DC) down --remove-orphans
.PHONY: rm

down:
	$(DC) down --remove-orphans  --volumes
.PHONY: down

angular-cli:
	$(if $(AV),env ANGULAR_ROOT=${PWD}/$(AV),) $(DC_RUN) -p 4200 angular bash
.PHONY: angular-cli

angular-serve:
	$(if $(AV),env ANGULAR_ROOT=${PWD}/$(AV),) $(DC_RUN) -p 4200 angular ng serve --disableHostCheck --host 0.0.0.0
.PHONY: angular-serve

karma-test:
	$(DC_RUN) -p 9876:9876 angular ng test --watch
.PHONY: karma-test

karma-cli:
	$(if $(AV),env ANGULAR_ROOT=${PWD}/$(AV),) $(DC_RUN) -p 9876 angular bash
.PHONY: karma-cli

karma-test-ci:
	$(DC_RUN) angular npm run test:ci
.PHONY: karma-test-ci

php-cli:
	$(DC_RUN) php7fpm bash
.PHONY: php-cli

mysql-cli:
	$(DC_RUN) mysql mysql  -uroot -ppassword -hmysql
.PHONY: mysql-cli

logf: ARG:=-f $(ARG)
logf: logs
log: logs
logs:
	$(DC) logs $(ARG)
.PHONY: logs

build:
	$(DC) build
.PHONY: build

pull:
	$(DC) pull --ignore-pull-failures --include-deps
.PHONY: pull

push:
	$(DC) push --ignore-push-failures
.PHONY: push

ps:
	$(DC) ps
.PHONY: ps

top:
	$(DC) top
.PHONY: top

wait-mysql:
	while ! $(DC_EXEC) mysql mysqladmin ping -h"mysql" -uroot -ppassword --silent; do sleep 1; done;
PHONY: wait-mysql

recreate-db:
	$(DC_EXEC) mysql mysql  -uroot -ppassword --execute='DROP DATABASE IF EXISTS todo; CREATE DATABASE todo;'
.PHONY: recreate-db
