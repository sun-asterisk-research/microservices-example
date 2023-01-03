_DEV_TARGETS := up down sh
_DEV_CONTAINERS := web api
_DEV_VOLUMES := .docker/data .docker/run/postgresql

ifneq (,$(filter $(_DEV_TARGETS),$(firstword $(MAKECMDGOALS))))
    $(shell mkdir -p $(_DEV_VOLUMES))

	ifeq (,$(wildcard .env))
        $(shell cp .env.example .env)
	endif

	ifeq (true, $(shell docker compose version > /dev/null 2>&1 && echo true))
		DOCKER_COMPOSE := docker compose
	else ifeq (true, $(shell docker-compose version > /dev/null 2>&1 && echo true))
		DOCKER_COMPOSE := docker-compose
	else
		ERR := $(error Docker compose is not installed. Refer to the documentation for instructions: https://docs.docker.com/compose/install/compose-plugin)
	endif

	export UID=$(shell id -u)
endif

ifeq (sh,$(firstword $(MAKECMDGOALS)))
	SH_CONTAINER := $(firstword $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS)))
    $(eval $(SH_CONTAINER):;@:)

	ifneq (,$(filter $(_DEV_CONTAINERS),$(SH_CONTAINER)))
		SH_EXEC_OPTS := -u $(UID):$(UID) -e USER=$$USER -e HOME=/tmp
	endif
endif

up:
	$(DOCKER_COMPOSE) up -d --remove-orphans

down:
	$(DOCKER_COMPOSE) down --remove-orphans

sh:
	@($(DOCKER_COMPOSE) exec -it $(SH_EXEC_OPTS) $(SH_CONTAINER) sh -c "command -v bash >/dev/null && exec bash --login || exec sh") || true

clean:
	sudo rm -rf $(_DEV_VOLUMES)
