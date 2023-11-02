COMPOSE=docker compose

.PHONY: up build down

build:
	docker build -t jenkins_jcasc:${JENKINS_VERSION} .

up:
	${COMPOSE} up -d

down: 
	${COMPOSE} down