CONF_PATH=/etc/drone
SERVER_DEFINITION_FILE=drone-server.yml
AGENT_DEFINITION_FILE=drone-agent.yml

all: help

help:
	@echo "run_server: rebuild & run docker-compose definition for drone-server."
	@echo "run_agent: rebuild & run docker-compose definition for drone-agent."

run_definition:
	docker-compose --file $(CONF_PATH)/$(DEFINITION_FILE) up --force-recreate -d

run_server:
	DEFINITION_FILE=$(SERVER_DEFINITION_FILE) make run_definition

run_agent:
	DEFINITION_FILE=$(AGENT_DEFINITION_FILE) make run_definition
