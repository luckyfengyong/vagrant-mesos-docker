vagrant-mesos-docker
================================

# Introduction
vagrant scripts to set up Mesos environment by Docker

1. zoo-keeper
```
docker run --net=host registry.dataman.io/zookeeper /bin/bash /usr/local/share/zookeeper/start.sh -h=192.168.100.25:1,192.168.100.27:2,192.168.100.28:3  
```

2. mesos-master
```
docker run  --net=host registry.dataman.io/mesos-master --zk=zk://192.168.100.30:2181,192.168.100.31:2181,192.168.100.32:2181/dataman --cluster=DataManCloud  --quorum=2 --work_dir=/tmp --hostname=`ifconfig eth0 | awk '/inet addr/{print substr($2,6)}'`
```

3. mesos-slave
```
docker run --net=host registry.dataman.io/mesos-slave --master=zk://192.168.100.30:2181,192.168.100.31:2181,192.168.100.32:2181/dataman --hostname=`ifconfig eth0 | awk '/inet addr/{print substr($2,6)}'`  
```

4. marathon
```
docker run --net=host registry.dataman.io/marathon:v0.7.6 --ha --master zk://192.168.100.30:2181,192.168.100.31:2181,192.168.100.32:2181/dataman --zk_hosts 192.168.100.30:2181,192.168.100.31:2181,192.168.100.32:2181 --hostname `ifconfig eth0 | awk '/inet addr/{print substr($2,6)}'` 
```

5. chronos
```
docker run --net=host registry.dataman.io/chronos /usr/local/bin/chronos --master zk://192.168.100.30:2181,192.168.100.31:2181,192.168.100.32:2181/dataman --zk_hosts 192.168.100.30:2181,192.168.100.31:2181,192.168.100.32:2181 --http_port 8081'`  
```

6. spark job on Mesos
```
docker run --rm -e "MASTER=mesos://zk://192.168.100.30:2181,192.168.100.31:2181,192.168.100.32:2181/dataman"  --net=host registry.dataman.io/spark-on-dataman /bin/bash -c "nginx && wget <a href="http://www.datman.io/download/examples.jar">http://www.datman.io/download/examples.jar</a> && /usr/local/share/spark/bin/spark-submit --class org.apache.spark.examples.SparkPi --conf spark.executor.uri=http://192.168.100.30/spark-on-dataman.tgz  /usr/local/share/examples.jar 2"  
```