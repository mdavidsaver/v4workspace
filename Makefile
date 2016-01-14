
all:
	$(MAKE) -C epics-base
	$(MAKE) -C pvData
	$(MAKE) -C pvAccess
	$(MAKE) -C pvaSrv/configure
	$(MAKE) -C pvaSrv/src
	$(MAKE) -C normativeTypes
	$(MAKE) -C pvaClient/configure
	$(MAKE) -C pvaClient/src
	$(MAKE) -C pvaPy

.PHONY: all
