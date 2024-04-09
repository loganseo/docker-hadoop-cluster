show databases;

create database test;

CREATE TABLE test.my_first_table
(
  id BIGINT,
  name STRING,
  PRIMARY KEY(id)
)
PARTITION BY HASH PARTITIONS 3
STORED AS KUDU
TBLPROPERTIES("kudu.master_addresses" = "kudu-master:7051", "kudu.num_tablet_replicas" = "1");