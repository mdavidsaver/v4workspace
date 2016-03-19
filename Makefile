all: base
	$(MAKE) -C pvData
	$(MAKE) -C pvAccess
	$(MAKE) -C pva2pva
	$(MAKE) -C pvaSrv
	$(MAKE) -C normativeTypes
	$(MAKE) -C pvaClient
	$(MAKE) -C pvaPy

base: RELEASE.local
	$(MAKE) -C epics-base

clean:
	$(MAKE) -C pvData distclean
	$(MAKE) -C pvAccess distclean
	$(MAKE) -C pva2pva distclean
	$(MAKE) -C pvaSrv distclean
	$(MAKE) -C normativeTypes distclean
	$(MAKE) -C pvaClient distclean
	$(MAKE) -C pvaPy distclean

distclean: clean
	$(MAKE) -C epics-base distclean
	rm -f RELEASE.local


RELEASE.local: RELEASE.local.in
	echo "THE_ROOT_DIR=$$PWD" > $@
	cat $< >> $@

.PHONY: all clean base distclean
