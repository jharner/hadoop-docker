#!/bin/sh

if [[ ! -e pgdata ]]; then
	mkdir pgdata
fi

if [[ ! -e rstudio-data ]]; then
	mkdir rstudio-data
fi

if [[ ! -e hadoop-data ]]; then
	mkdir hadoop-data
fi

docker-compose up
