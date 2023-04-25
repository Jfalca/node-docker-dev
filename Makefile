include .env

default:
	up-build

up:
	docker-compose up -d

up-build:
	docker-compose up --build -d

up-db:
	docker-compose up -d dev_postgres

down:
	docker-compose down --remove-orphans

start:
	docker-compose start

stop:
	docker-compose stop

console:
	docker exec -it dev_api /bin/bash

console-root:
	docker exec -it -u 0 dev_api /bin/bash

purge:
	docker system prune --all --force --volumes

# APP UTIL
all-permissions:
	sudo chown -R 1000:1000 .

kill-app-port:
	sudo kill -9 $(sudo lsof -t -i:3333)

kill-debug-port:
	sudo kill -9 $(sudo lsof -t -i:9229)

kill-postgres-port:
	sudo kill -9 $(sudo lsof -t -i:5432)
