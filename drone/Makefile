CONF_PATH=/etc/drone
SERVER_DEFINITION_FILE=drone-server.yml
AGENT_DEFINITION_FILE=drone-agent.yml

all: help

help:
	@echo "install_server: install docker-compose definition file for drone-server."
	@echo "install_agent: install docker-compose definition file for drone-agent."
	@echo "run_server: rebuild & run docker-compose definition for drone-server."
	@echo "run_agent: rebuild & run docker-compose definition for drone-agent."

install_definition:
	mkdir -p $(CONF_PATH)
	if [ -f $(CONF_PATH)/$(DEFINITION_FILE) ]; then \
		mv $(CONF_PATH)/$(DEFINITION_FILE) $(CONF_PATH)/$(DEFINITION_FILE).bak; \
	fi; \
	install -m0640 -o root -g root $(DEFINITION_FILE) $(CONF_PATH)/$(DEFINITION_FILE)

run_definition:
	docker-compose --file $(CONF_PATH)/$(DEFINITION_FILE) up --force-recreate -d

install_server:
	DEFINITION_FILE=$(SERVER_DEFINITION_FILE) make install_definition

install_agent:
	DEFINITION_FILE=$(AGENT_DEFINITION_FILE) make install_definition

run_server:
	DEFINITION_FILE=$(SERVER_DEFINITION_FILE) make run_definition

run_agent:
	DEFINITION_FILE=$(AGENT_DEFINITION_FILE) make run_definition
