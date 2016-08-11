all: real-all

distclean: RELEASE.local
	$(MAKE) -C pvData $@
	$(MAKE) -C pvAccess $@
	$(MAKE) -C normativeTypes $@
	$(MAKE) -C masarService $@
	$(MAKE) -C pvaSrv $@
	$(MAKE) -C pvaClient $@
	$(MAKE) -C pvaPy $@
	$(MAKE) -C pva2pva $@
	# must be last as this removes some configure/*
	$(MAKE) -C epics-base $@

real-%: RELEASE.local
	$(MAKE) -C epics-base $*
	$(MAKE) -C pvData $*
	$(MAKE) -C pvAccess $*
	$(MAKE) -C pvaSrv $*
	$(MAKE) -C normativeTypes $*
	$(MAKE) -C masarService $*
	$(MAKE) -C pvaClient $*
	$(MAKE) -C pvaPy $*
	$(MAKE) -C pva2pva $*

clean:
	rm -f RELEASE.local

RELEASE.local: RELEASE.local.in
	echo "THE_ROOT_DIR=$$PWD" > $@
	cat $< >> $@

.PHONY: all clean distclean
