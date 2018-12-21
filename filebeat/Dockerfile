# Copyright Zhigui.com. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0

# https://www.docker.elastic.co/
# https://github.com/elastic/beats-docker

FROM docker.elastic.co/beats/filebeat:6.5.4
COPY filebeat.yml.tmpl /usr/share/filebeat/filebeat.yml
USER root
RUN chown root:filebeat /usr/share/filebeat/filebeat.yml
USER filebeat

#docker run -d \
#  --name=filebeat \
#  --user=root \
#  --volume="/var/lib/docker/containers:/var/lib/docker/containers:ro" \
#  --volume="/var/run/docker.sock:/var/run/docker.sock:ro" \
#  zhigui/filebeat:6.5.4 filebeat -e -strict.perms=false \
#  -E ELASTIC_SEARCH_HOST="localhost:9200"