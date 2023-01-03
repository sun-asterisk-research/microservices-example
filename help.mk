define HELP_MSG
Microservices example

Usage:
  make [TARGET] [OPTION=VALUE...]

Targets:
  help   This help message
  up     Bring the development stack up
  down   Stop and remove development containers
  sh     Spawn a shell and exec into a container
  clean  Stop containers and remove all data

Run "make help [TARGET]" to see help for a specific target
endef

define SH_HELP
Spawn a shell and exec into a container

Usage:
  make sh [CONTAINER]
endef

ifeq (help,$(firstword $(MAKECMDGOALS)))
HELP_FOR_CMD := $(firstword $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS)))

ifneq (,$(HELP_FOR_CMD))
HELP_MSG := $($(shell echo $(HELP_FOR_CMD) | tr - _ | tr '[[:lower:]]' '[[:upper:]]')_HELP)
$(eval $(CONTAINER):;@:)
endif

%:
	@:
endif

export HELP_MSG

help:
ifneq (,$(HELP_MSG))
	@printf '%s\n' "$$HELP_MSG"
else
	@echo No help message for "$(HELP_FOR_CMD)"
endif
