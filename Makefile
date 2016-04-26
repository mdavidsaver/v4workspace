all: real-all
distclean: real-distclean

real-%: RELEASE.local
	$(MAKE) -C epics-base $*
	$(MAKE) -C pvData $*
	$(MAKE) -C pvAccess $*
	$(MAKE) -C pvaSrv $*
	$(MAKE) -C normativeTypes $*
	$(MAKE) -C pvaClient $*
	$(MAKE) -C pvaPy $*
	$(MAKE) -C pva2pva $*

clean:
	rm -f RELEASE.local

RELEASE.local: RELEASE.local.in
	echo "THE_ROOT_DIR=$$PWD" > $@
	cat $< >> $@

.PHONY: all clean
