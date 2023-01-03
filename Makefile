include help.mk

ifneq (help,$(firstword $(MAKECMDGOALS)))
	include dev.mk
endif
