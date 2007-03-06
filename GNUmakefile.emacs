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

EMACS_VERSION := emacs-20051204.220257
sourcetar := $(EMACS_VERSION).tar.gz 

staging-archives/$(THING).tar.gz: staging/Applications/$(THING)
	(cd staging/Applications/; tar czf - $(THING)) > $@

staging/Applications/Emacs.app: staging/Emacs.pax
	cd staging; pax -r -f Emacs.pax './Applications/Emacs.app'

staging/Emacs.pax: staging/Emacs.pax.gz
	cd staging; gunzip Emacs.pax.gz

.SECONDARY: /Volumes/Emacs

staging/Emacs.pax.gz: /Volumes/Emacs
	cp /Volumes/Emacs/Emacs.pkg/Contents/Resources/Emacs.pax.gz staging/Emacs.pax.gz

/Volumes/Emacs: staging/$(EMACS_VERSION)/mac/EmacsInstaller.dmg
	hdiutil attach staging/$(EMACS_VERSION)/mac/EmacsInstaller.dmg

staging/$(EMACS_VERSION)/mac/EmacsInstaller.dmg: source-archives/$(sourcetar)
	mkdir -p staging
	cat $< | (cd staging; tar xzf - )
	cd staging/$(EMACS_VERSION)/mac; ./make-package --self-contained

endif

ifeq ($(os),Windows)

staging-archives/$(THING).tar.gz: staging/$(THING)
	(cd staging; tar czf - $(THING)) > $@

staging/$(THING): binary-archives/$(THING)-fullbin-i386.tar.gz 
	cat $< | (cd staging; tar xzf -)

endif
