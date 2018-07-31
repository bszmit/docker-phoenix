docker-phoenix
==============

A Docker image to quick start [Apache Phoenix](http://phoenix.apache.org/) on [Apache HBase](https://hbase.apache.org/)
to provide an SQL interface.

Apache Phoenix is a SQL skin over HBase delivered as a client-embedded JDBC driver targeting low latency queries over HBase data. Apache Phoenix takes your SQL query, compiles it into a series of HBase scans, and orchestrates the running of those scans to produce regular JDBC result sets. The table metadata is stored in an HBase table and versioned, such that snapshot queries over prior versions will automatically use the correct schema. Direct use of the HBase API, along with coprocessors and custom filters, results in performance on the order of milliseconds for small queries, or seconds for tens of millions of rows.

docker pull bszmit/hbase-phoenix

### Versions
Apache Hadoop - 2.7.0  
Apache HBase - 1.1.2  
Apache Phoenix - 4.7.0

### Launch
- Add `127.0.0.1 docker-phoenix` to `/etc/hosts`
- docker run -p 2181:2181 -p 8765:8765 -p 16000:16000 -p 16201:16201 -h docker-phoenix -it bszmit/hbase-phoenix /etc/bootstrap-phoenix.sh -sqlline

You can provide your initialization script for Phoenix sqlline:
- docker run -p 2181:2181 -p 8765:8765 -p 16000:16000 -p 16201:16201 -h docker-phoenix -it bszmit/hbase-phoenix /etc/bootstrap-phoenix.sh -sqlline my_init_script.sql

