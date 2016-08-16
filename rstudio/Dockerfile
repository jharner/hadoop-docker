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
RUN Rscript -e "install.packages(c(\"rjson\",\"bit64\",\"bit\",\"functional\",\"RJSONIO\",\"R.methodsS3\",\"reshape2\",\"datadr\",\"trelliscope\",\"DBI\",\"RPostgreSQL\"))"
ADD rhdfs.tar.gz ravro.tar.gz rmr.tar.gz plyrmr.tar.gz rhbase.tar.gz /tmp/pkgs/
RUN cd /tmp/pkgs && R CMD INSTALL ravro rmr2 plyrmr rhdfs rhbase

RUN cd /opt && \
	wget --quiet http://apache.mesi.com.ar/spark/spark-2.0.0/spark-2.0.0-bin-without-hadoop.tgz && \
	tar zxf spark-2.0.0-bin-without-hadoop.tgz && \
	mv spark-2.0.0-bin-without-hadoop spark && \
	cp spark/conf/spark-env.sh.template spark/conf/spark-env.sh && \
	echo "export SPARK_DIST_CLASSPATH=$(/opt/hadoop/bin/hadoop classpath)" >> spark/conf/spark-env.sh

#add necessary mods to Renviron file
ADD Renviron /etc/R/

ADD hdfs-site.xml /opt/hadoop/etc/hadoop/
ADD core-site.xml /opt/hadoop/etc/hadoop/
ADD log4j.properties /opt/hadoop/etc/hadoop/

#ENV HADOOP_PREFIX /opt/hadoop
#ENV HADOOP_COMMON_HOME /opt/hadoop
#ENV HADOOP_HDFS_HOME /opt/hadoop
#ENV HADOOP_MAPRED_HOME /opt/hadoop
#ENV HADOOP_YARN_HOME /opt/hadoop
#ENV HADOOP_CONF_DIR /opt/hadoop/etc/hadoop
#ENV YARN_CONF_DIR $HADOOP_PREFIX/etc/hadoop

#RUN cd /tmp && wget http://ml.stat.purdue.edu/rhipebin/Rhipe_0.75.2_hadoop-2.tar.gz
#RUN Rscript -e "install.packages(\"Rhipe_0.75.2_hadoop-2.tar.gz\", repos=NULL, type=\"source\")"

#ADD delayed-init.sh /


EXPOSE 8787
#VOLUME /home/rstudio

CMD ["/init"]


	
