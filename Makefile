export ROOT_PATH = ${PWD}
-include .makerc/help
-include .makerc/log

start: ##@service Start service
	@docker-compose up -d

stop: ##@service Stop service
	@docker-compose down

setup-node: ##@service setup log node
	@curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-$(FILEBEAT_VERSION)-amd64.deb
	@dpkg -i filebeat-$(FILEBEAT_VERSION)-amd64.deb
	@apt-get update && apt-get install -y supervisor
	@cp filebeat/supervisor/conf.d/filebeat.conf /etc/supervisor/conf.d/filebeat.conf

start-node: ##@service start log node
	@envsubst < filebeat/filebeat.yml.tmpl > /etc/filebeat/filebeat.yml
	@service supervisor restart

stop-node: ##@service stop log node
	@service supervisor stop

HELP_FUN = \
	%help; \
	while(<>) { push @{$$help{$$2 // 'options'}}, [$$1, $$3] if /^([a-zA-Z\-]+)\s*:.*\#\#(?:@([a-zA-Z\-]+))?\s(.*)$$/ }; \
	print "usage: make [target]\n\n"; \
	for (sort keys %help) { \
	print "${WHITE}$$_:${RESET}\n"; \
	for (@{$$help{$$_}}) { \
	$$sep = " " x (32 - length $$_->[0]); \
	print "  ${YELLOW}$$_->[0]${RESET}$$sep${GREEN}$$_->[1]${RESET}\n"; \
	}; \
	print "\n"; }

help: ##@other Show this help.
	@perl -e '$(HELP_FUN)' $(MAKEFILE_LIST)
