FROM library/ubuntu:xenial
MAINTAINER Mark Lilback <mark@lilback.com>

ARG pgversion=9.4

RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN apt-get update && apt-get install -y python-software-properties software-properties-common postgresql-${pgversion} postgresql-client-${pgversion} postgresql-contrib-${pgversion} libpq-dev
RUN mkdir -p /opt/pgdata; chown -R postgres /opt/pgdata; chmod 700 /opt/pgdata
RUN locale-gen en_US.UTF-8
RUN pg_dropcluster ${pgversion} main
RUN pg_createcluster -d /opt/pgdata --locale=en_US.UTF-8 ${pgversion} main

USER postgres
COPY *.conf /etc/postgresql/${pgversion}/main/
COPY runpg.sh /var/lib/postgresql/runpg.sh
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

EXPOSE 5432

CMD ["var/lib/postgresql/runpg.sh", "9.4"]
