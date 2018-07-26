FROM sequenceiq/hadoop-docker:2.7.0
MAINTAINER bszmit

# zookeeper
ENV ZOOKEEPER_VERSION 3.4.6
RUN curl -s https://archive.apache.org/dist/zookeeper/zookeeper-$ZOOKEEPER_VERSION/zookeeper-$ZOOKEEPER_VERSION.tar.gz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s ./zookeeper-$ZOOKEEPER_VERSION zookeeper
ENV ZOO_HOME /usr/local/zookeeper
ENV PATH $PATH:$ZOO_HOME/bin
RUN mv $ZOO_HOME/conf/zoo_sample.cfg $ZOO_HOME/conf/zoo.cfg
RUN mkdir /tmp/zookeeper

# hbase
ENV HBASE_MAJOR 1.1
ENV HBASE_MINOR 2
ENV HBASE_VERSION "${HBASE_MAJOR}.${HBASE_MINOR}"
RUN curl -s http://archive.apache.org/dist/hbase/$HBASE_MAJOR.$HBASE_MINOR/hbase-$HBASE_MAJOR.$HBASE_MINOR-bin.tar.gz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s ./hbase-$HBASE_VERSION hbase
ENV HBASE_HOME /usr/local/hbase
ENV PATH $PATH:$HBASE_HOME/bin
RUN rm $HBASE_HOME/conf/hbase-site.xml
ADD hbase-site.xml $HBASE_HOME/conf/hbase-site.xml

# phoenix
ENV PHOENIX_VERSION 4.7.0
RUN curl -s http://archive.apache.org/dist/phoenix/phoenix-$PHOENIX_VERSION-HBase-$HBASE_MAJOR/bin/phoenix-$PHOENIX_VERSION-HBase-$HBASE_MAJOR-bin.tar.gz | tar -xz -C /usr/local/
RUN cd /usr/local && ln -s ./phoenix-$PHOENIX_VERSION-HBase-$HBASE_MAJOR-bin phoenix
ENV PHOENIX_HOME /usr/local/phoenix
ENV PATH $PATH:$PHOENIX_HOME/bin
RUN cp $PHOENIX_HOME/phoenix-core-$PHOENIX_VERSION-HBase-$HBASE_MAJOR.jar $HBASE_HOME/lib/phoenix.jar
RUN cp $PHOENIX_HOME/phoenix-server-$PHOENIX_VERSION-HBase-$HBASE_MAJOR.jar $HBASE_HOME/lib/phoenix-server.jar

# bootstrap-phoenix
ADD listtables.sql /etc/listtables.sql
ADD bootstrap-phoenix.sh /etc/bootstrap-phoenix.sh
RUN chown root:root /etc/bootstrap-phoenix.sh
RUN chmod 700 /etc/bootstrap-phoenix.sh

CMD ["/etc/bootstrap-phoenix.sh"]

EXPOSE 2181
EXPOSE 8765
EXPOSE 16000 16201

