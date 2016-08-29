FROM rocker/hadleyverse
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

RUN apt-get update && apt-get install -y postgresql-client-9.4 && apt-get clean

#thrift is required for rhbase
ADD thrift_0.8.0-1_amd64.deb /tmp/
RUN dpkg -i /tmp/thrift_0.8.0-1_amd64.deb && \
	rm -rf /tmp/thrift_0.8.0-1_amd64.deb && \
	ln -s /usr/local/lib/libthrift-0.8.0.so /usr/lib/ && ls -l /usr/lib/libt*

ADD protobuf-2.5.0.tar.gz /tmp
RUN cd /tmp/protobuf-2.5.0 && ./configure && make -j4 && make install && cd .. && rm -rf protobuf-*

RUN cd /opt && wget --quiet http://apache.mirrors.hoobly.com/hadoop/common/hadoop-2.7.2/hadoop-2.7.2.tar.gz && \
	tar zxf hadoop-2.7.2.tar.gz && ln -s hadoop-2.7.2 hadoop && rm hadoop-2.7.2.tar.gz
RUN mkdir native && cd native && wget --quiet https://github.com/sequenceiq/docker-hadoop-build/releases/download/v2.7.1/hadoop-native-64-2.7.1.tgz && tar zxf hadoop-native-64-2.7.1.tgz && rm hadoop-native-64-2.7.1.tgz && cd ..
RUN rm -rf /opt/hadoop/lib/native && mv native /opt/hadoop/lib
ENV HADOOP_CMD /opt/hadoop/bin/hadoop
RUN Rscript -e "install.packages(c(\"rjson\",\"bit64\",\"bit\",\"functional\",\"RJSONIO\",\"R.methodsS3\",\"reshape2\",\"datadr\",\"trelliscope\",\"DBI\",\"RPostgreSQL\",\"RJDBC\", \"sparklyr\"))"
ADD rhdfs.tar.gz ravro.tar.gz rmr.tar.gz plyrmr.tar.gz rhbase.tar.gz /tmp/pkgs/
RUN cd /tmp/pkgs && R CMD INSTALL ravro rmr2 plyrmr rhdfs rhbase
RUN Rscript -e "devtools::install_github(\"rstudio/sparklyr\")"

RUN cd /opt && \
	wget --quiet http://apache.mirrors.hoobly.com/spark/spark-1.6.2/spark-1.6.2-bin-without-hadoop.tgz && \
	tar zxf spark-1.6.2-bin-without-hadoop.tgz && \
	mv spark-1.6.2-bin-without-hadoop spark && \
	cp spark/conf/spark-env.sh.template spark/conf/spark-env.sh && \
	echo "export SPARK_DIST_CLASSPATH=$(/opt/hadoop/bin/hadoop classpath)" >> spark/conf/spark-env.sh

RUN cd /opt && \
	wget --quiet http://apache.mirrors.hoobly.com/hive/hive-2.1.0/apache-hive-2.1.0-bin.tar.gz && \
	tar zxf apache-hive-2.1.0-bin.tar.gz && \
	ln -s apache-hive-2.1.0-bin hive && \
	ln -s /opt/hive/jdbc/hive-jdbc-2.1.0-standalone.jar /opt/hive/lib/ && \
	rm apache-hive-2.1.0-bin.tar.gz


#add necessary mods to Renviron file
ADD Renviron /etc/R/

ADD hdfs-site.xml /opt/hadoop/etc/hadoop/
ADD core-site.xml /opt/hadoop/etc/hadoop/
ADD log4j.properties /opt/hadoop/etc/hadoop/


EXPOSE 8787
#VOLUME /home/rstudio

CMD ["/init"]


	
