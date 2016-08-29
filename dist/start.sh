#!/bin/sh

if [[ "reset" -eq $1 ]]; then
	rm -rf data/pg-data data/hadoop
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
