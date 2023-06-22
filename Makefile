COMPOSE=docker compose

.PHONY: up build

build:
	docker build -t jenkins_jcasc:${JENKINS_VERSION} .

up:
	${COMPOSE} up -d