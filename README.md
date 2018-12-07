# Dashboard-ELK
![img](./elk-stack-elkb-diagram.png)

We use filebeat to collect docker container logs under `/var/lib/docker/containers/*/*.log`. At current, filebeat forwards logs to elastic directly and logstash might be integrated to do logging process work in the future. You can search logs from the kibana UI or call the elastic api directly.

## Quick start
> Only tested on Ubuntu.

1. Setup the endpoint properly in the config file `.makerc/log`.

2. Start the elastic server, kibana and nginx:
```
make start
```

3. Start the filebeat on service node:
```
make setup-node && make start-node
```
Before running the filebeat, you need to install and configure the elastic server. Except Ubuntu, follow the installation instructions [here](https://www.elastic.co/guide/en/beats/filebeat/6.1/filebeat-installation.html#filebeat-installation) for other operating systems.

4. After a while, visit the [localhost:5601](http://localhost:5601/) and you can search the logs.
> No default index pattern. You must select or create one at the first time.

