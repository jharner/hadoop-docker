#!/bin/sh

if [[ "build" -eq $1 ]]; then
	docker build -t jh-postgres postgres
	docker build -t jh-hadoop hadoop
	docker build -t jh-hive hive
	docker build -t jh-rstudio rstudio
fi

if [[ ! -e data ]]; then
	mkdir data
fi

if [[ ! -e data/pg-data ]]; then
	mkdir data/pg-data
fi

if [[ ! -e data/rstudio ]]; then
	mkdir data/rstudio
fi

if [[ ! -e data/hadoop ]]; then
	mkdir data/hadoop
fi

docker-compose up
