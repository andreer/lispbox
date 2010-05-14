#
# Makefile to build binary archive Emacs.
#

all: staging-archives/$(THING).tar.gz

include GNUmakefile.base

ifeq ($(os),Linux)

staging-archives/$(THING).tar.gz: $(prefix)/$(THING)
	(cd $(prefix); tar czf - $(THING)) > $@

$(prefix)/$(THING): staging/$(THING)/src/thing
	cd staging/$(THING); $(MAKE) install

staging/$(THING)/src/thing: staging/$(THING)/src/Makefile
	cd staging/$(THING); $(MAKE)

staging/$(THING)/src/Makefile: staging/$(THING)
	cd staging/$(THING); ./configure --with-x --prefix=$(prefix)/$(THING)

staging/$(THING): source-archives/$(THING).tar.gz 
	cat $< | (cd staging; tar xzf -)

endif

ifeq ($(os),Darwin)

sourcetar := $(EMACS_VERSION).tar.gz 

staging-archives/$(THING).tar.gz: staging/$(EMACS_VERSION)/nextstep/$(THING)
	(cd staging/$(EMACS_VERSION)/nextstep; tar czf - $(THING)) > $@

staging/$(EMACS_VERSION)/nextstep/$(THING): source-archives/$(sourcetar)
	mkdir -p staging
	cat $< | (cd staging; tar xzf - )
	cd staging/$(EMACS_VERSION); ./configure --with-ns && make install

endif

ifeq ($(os),Windows)

staging-archives/$(THING).tar.gz: staging/$(THING)
	(cd staging; tar czf - $(THING)) > $@

staging/$(THING): binary-archives/$(THING)-bin-i386.zip
	cat $< | (cd staging; tar xzf -)

endif
