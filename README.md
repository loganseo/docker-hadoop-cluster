# Hadoop Cluster Quickstart Docker

## Installed Softwares
- hadoop:3.3.6
- spark:3.5.1
- impala:4.0.0
- kudu:1.17.0
- hue:4.11.0
- jupyter

## Spark, Jupyter 용 이미지 빌드
```bash
docker build -f ./spark/spark.Dockerfile -t spark3 .
```

## Docker Container 생성
```bash
docker network create -d bridge hadoop-network
docker-compose -f ./docker-compose.yml --project-name=dev-cluster up -d
```

## namenode 에서 httpfs 구동
```bash
hdfs --daemon start httpfs
```

## nodemanager01 에서 Spark history server 구동 (/opt/spark/setup-history-server.sh)
```bash
hdfs dfs -mkdir -p /user/spark/applicationHistory
hdfs dfs -chown -R spark:hadoop /user/spark/applicationHistory
hdfs dfs -chmod -R 777 /user/spark/applicationHistory
/opt/spark/sbin/start-history-server.sh
```

## jupyter log 정보에서 token 복사 후 jupyter web ui 에서 Password or token 에 입력 후 Log in
```
예시)
2024-04-01 14:03:19 [I 05:03:19.487 NotebookApp] http://jupyter:7777/?token=8c55ff2df02908e9d1b91a766dd89245c25511e6a2687f08
2024-04-01 14:03:19 [I 05:03:19.487 NotebookApp]  or http://127.0.0.1:7777/?token=8c55ff2df02908e9d1b91a766dd89245c25511e6a2687f08
```

## WebUI 접속 정보
- [Jupyter](http://localhost:7777/)
- [Hue](http://localhost:8888/)
- [Impala Daemon](http://localhost:25000/)
- [Impala StateStore](http://localhost:25010/)
- [Impala Catalog](http://localhost:25020/)
- [HDFS Namenode information](http://localhost:9870/dfshealth.html#tab-overview)
- [YARN Resource Manager - All Applications](http://localhost:8088/cluster)
- [Kudu Master](http://localhost:8051)
- [Kudu Tablet Server](http://localhost:8050/)
