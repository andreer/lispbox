#
# GNUmakefile to build Practical Common Lisp Lispbox distro.
# Copyright 2005 Peter Seibel.
#

# N.B. I know about the z flag to tar. However, on OS X gzip complains
# about trailing garbage if not passed the -q flag. And tar doesn't
# seem to pay attention to the GZIP environment variable.

include GNUmakefile.vars

#LISPBOX_LISP            := sbcl
LISPBOX_LISP            := openmcl
GNU_LINUX_EMACS_VERSION := 21.4
WINDOWS_EMACS_VERSION   := 21.3
CLISP_VERSION           := 2.41
ALLEGRO_VERSION         := 70_trial
SBCL_VERSION            := 1.0.3
#OPENMCL_VERSION         := 1.0
OPENMCL_VERSION         := 070408
OPENMCL_PLATFORM        := darwinx8664
#OPENMCL_PLATFORM        := darwinppc
OPENMCL_RELEASE         := snapshot
#OPENMCL_SCRIPT         	:= openmcl
OPENMCL_SCRIPT         	:= openmcl64
SLIME_VERSION           := 20070306.205402
PRACTICALS_VERSION      := 1.0.3
PORTABLEASERVE_VERSION  := 1.2.35

ifeq ($(os),Linux)
emacs := emacs-$(GNU_LINUX_EMACS_VERSION)
endif
ifeq ($(os),Darwin)
emacs := Emacs.app
endif
ifeq ($(os),Windows)
emacs := emacs-$(WINDOWS_EMACS_VERSION)
endif

clisp   := clisp-$(CLISP_VERSION)
allegro := acl$(ALLEGRO_VERSION)
sbcl    := sbcl-$(SBCL_VERSION)
openmcl := openmcl-$(OPENMCL_PLATFORM)-$(OPENMCL_RELEASE)-$(OPENMCL_VERSION)

lisp       := $($(LISPBOX_LISP))
slime      := slime-$(SLIME_VERSION)
practicals := practicals-$(PRACTICALS_VERSION)

ifeq ($(os),Darwin)
lispbox_script_dir := $(prefix)/Emacs.app/Contents/MacOS
emacs_lisp    := $(prefix)/Emacs.app/Contents/Resources/lisp
emacs_site_lisp    := $(prefix)/Emacs.app/Contents/Resources/site-lisp
export LISPBOX_HOME_RELATIVE := /../../..
export EMACS_EXE := Emacs.app/Contents/MacOS/Emacs
endif
ifeq ($(os),Linux)
lispbox_script_dir := $(prefix)
emacs_site_lisp    := $(prefix)/$(emacs)/share/emacs/site-lisp
export LISPBOX_HOME_RELATIVE :=
export EMACS_EXE := $(emacs)/bin/emacs
export LINUX=yes
endif
ifeq ($(os),Windows)
lispbox_script_dir := $(prefix)
emacs_site_lisp    := $(prefix)/$(emacs)/site-lisp
export LISPBOX_HOME_RELATIVE :=
export EMACS_EXE := $(emacs)/bin/runemacs.exe
endif

export EMACS := $(emacs)

lispbox_elisp_dir := $(if $(NO_EMACS),$(prefix),$(emacs_site_lisp))

all: distro

distros:
	$(MAKE) -f GNUmakefile.distros

clean:
	rm -rf staging
	rm -rf $(prefix)

source-dist: $(LISPBOX_HOME)-source.tar.gz

$(LISPBOX_HOME)-source.tar.gz:
	mkdir $(prefix)
	mkdir -p $(prefix)/binary-archives
	cp binary-archives/$(practicals).tar.gz $(prefix)/binary-archives/
	mkdir -p $(prefix)/source-archives
	mkdir -p $(prefix)/staging-archives
	cp asdf-extensions.lisp $(prefix)
	cp asdf.lisp $(prefix)
	cp COPYING $(prefix)
	cp ChangeLog $(prefix)
	cp GNUmakefile $(prefix)
	cp GNUmakefile.allegro $(prefix)
	cp GNUmakefile.base $(prefix)
	cp GNUmakefile.clisp $(prefix)
	cp GNUmakefile.emacs $(prefix)
	cp GNUmakefile.portableaserve $(prefix)
	cp GNUmakefile.practicals $(prefix)
	cp GNUmakefile.sbcl $(prefix)
	cp GNUmakefile.slime $(prefix)
	cp GNUmakefile.vars $(prefix)
	cp Info.plist $(prefix)
	cp OSXpackage.mk $(prefix)
	cp OSXdiskImage.mk $(prefix)
	cp README $(prefix)
	cp README.source $(prefix)
	cp write-lispbox-el.sh $(prefix)
	cp write-lispbox.sh $(prefix)
	cp lispbox.bat $(prefix)
	cp write-site-init-lisp.sh $(prefix)
	(cd $(TOP); tar czf - $(LISPBOX_HOME)) > $@

$(prefix) staging:
	mkdir -p $@

staging/%: source-archives/%.tar.gz staging
	cat $< | (cd staging; gzip -cdq | tar xf -)
	find $@ -exec touch {} \;

staging/%: source-archives/%.tar.bz2 staging
	cat $< | (cd staging; tar xjf -)
	find $@ -exec touch {} \;

######################################################################
# Installer

ifeq ($(os),Linux)
distro_no_emacs   := lispbox-$(LISPBOX_VERSION)-no-emacs-with-$(lisp).tar.gz
distro_with_emacs := lispbox-$(LISPBOX_VERSION)-$(lisp).tar.gz
distro_just_lisp  := lispbox-$(LISPBOX_VERSION)-just-lisp-$(lisp).tar.gz

distro := $(if $(JUST_LISP),$(distro_just_lisp),$(if $(NO_EMACS),$(distro_no_emacs),$(distro_with_emacs)))

distro: $(distro)

$(distro): lispbox
	(cd $(TOP); tar czf - $(LISPBOX_HOME)) > $@
endif

#ifeq ($(os),Darwin)
#distro_with_emacs := LispboxInstaller-$(LISPBOX_VERSION)-with-$(lisp).dmg
#distro_no_emacs   := LispboxInstallerNoEmacs-$(LISPBOX_VERSION)-with-$(lisp).dmg
#distro_just_lisp  := LispboxInstallerJustLisp-$(LISPBOX_VERSION)-$(lisp).dmg

ifeq ($(os),Darwin)
distro_with_emacs := Lispbox-$(LISPBOX_VERSION)-with-$(lisp).dmg
distro_no_emacs   := LispboxNoEmacs-$(LISPBOX_VERSION)-with-$(lisp).dmg
distro_just_lisp  := LispboxJustLisp-$(LISPBOX_VERSION)-$(lisp).dmg

distro := $(if $(JUST_LISP),$(distro_just_lisp),$(if $(NO_EMACS),$(distro_no_emacs),$(distro_with_emacs)))

distro: $(distro)

#$(distro): lispbox
#	$(MAKE) -f OSXpackage.mk clean all NAME=$(distro) LISPBOX_VERSION=$(LISPBOX_VERSION) LISPBOX_LISP=$(lisp)

$(distro): lispbox
	$(MAKE) -f OSXdiskImage.mk clean all NAME=$(distro) LISPBOX_VERSION=$(LISPBOX_VERSION) LISPBOX_LISP=$(lisp)

endif

ifeq ($(os),Windows)
distro_no_emacs   := lispbox-$(LISPBOX_VERSION)-no-emacs-with-$(lisp).zip
distro_with_emacs := lispbox-$(LISPBOX_VERSION)-$(lisp).zip
distro_just_lisp  := lispbox-$(LISPBOX_VERSION)-just-lisp-$(lisp).zip

distro := $(if $(JUST_LISP),$(distro_just_lisp),$(if $(NO_EMACS),$(distro_no_emacs),$(distro_with_emacs)))

distro: $(distro)

$(distro): lispbox
	(cd $(TOP); tar czf - $(LISPBOX_HOME)) > $@
endif


######################################################################
# Lispbox

lispbox: staging

ifndef JUST_LISP
ifndef NO_EMACS
lispbox: $(emacs)
ifeq ($(os),Windows)
lispbox: $(lispbox_script_dir)/lispbox.bat
endif
ifneq ($(os),Windows)
lispbox: $(lispbox_script_dir)/lispbox.sh
endif
ifeq ($(os),Darwin)
lispbox: $(prefix)/Emacs.app/Contents/Info.plist
endif # Darwin
endif # not NO_EMACS

lispbox: $(slime)
lispbox: $(practicals)
lispbox: $(prefix)/$(slime)/site-init.lisp
lispbox: $(lispbox_elisp_dir)/lispbox.el 
lispbox: $(prefix)/asdf.lisp 
lispbox: $(prefix)/asdf-extensions.lisp
ifneq ($(LISPBOX_LISP),allegro)
portableaserve := portableaserve-$(PORTABLEASERVE_VERSION)
lispbox: $(portableaserve)
endif # not allegro
endif # not JUST_LISP

lispbox: $(lisp)
lispbox: $(prefix)/$(lisp)/lispbox-register.el

$(lispbox_script_dir)/lispbox.bat: lispbox.bat
	cp $< $@

$(lispbox_script_dir)/lispbox.sh: write-lispbox.sh $(prefix)
	SBCL_DIR=$(sbcl) OPENMCL_DIR=$(openmcl) $(SH) $< > $@
	chmod +x $@

foo: $(lispbox_elisp_dir)/lispbox.el

$(lispbox_elisp_dir)/lispbox.el: write-lispbox-el.sh $(if $(NO_EMACS),$(prefix),$(emacs))
	SLIME_DIR=$(slime) SBCL_DIR=$(sbcl) OPENMCL_DIR=$(openmcl) $(SH) $< > $@

$(prefix)/$(slime)/site-init.lisp: write-site-init-lisp.sh $(prefix)/$(slime) 
	PRACTICALS=$(practicals) PORTABLEASERVE=$(portableaserve) $(SH) $< > $@
	chmod 0644 $@

$(prefix)/asdf.lisp: asdf.lisp
	cp $< $@
	chmod 0644 $@

$(prefix)/asdf-extensions.lisp: asdf-extensions.lisp
	cp $< $@
	chmod 0644 $@

$(prefix)/$(allegro)/lispbox-register.el: lisppath := (lispbox-list-to-filename (list (file-name-directory load-file-name) \"alisp\"))
$(prefix)/$(allegro)/lispbox-register.el: license  := \"devel.lic\"

ifneq ($(os),Windows)
$(prefix)/$(clisp)/lispbox-register.el:   lisppath := (lispbox-list-to-filename (list (file-name-directory load-file-name) \"bin\" \"clisp\")) \"-ansi\" \"-K\" \"full\" \"-B\" (lispbox-list-to-filename (list (file-name-directory load-file-name) \"lib\" \"clisp\"))
endif

ifeq ($(os),Windows)
$(prefix)/$(clisp)/lispbox-register.el:   lisppath := \
(lispbox-list-to-filename (list (file-name-directory load-file-name) \"full\" \"lisp.exe\")) \"-ansi\" \
\"-M\" (lispbox-list-to-filename (list (file-name-directory load-file-name) \"full\" \"lispinit.mem\")) \
\"-B\" (lispbox-list-to-filename (list (file-name-directory load-file-name) \"full/\"))
endif



$(prefix)/$(sbcl)/lispbox-register.el:    lisppath := (lispbox-list-to-filename (list (file-name-directory load-file-name) \"bin\" \"sbcl\"))
$(prefix)/$(openmcl)/lispbox-register.el: lisppath := (lispbox-list-to-filename (list (file-name-directory load-file-name) \"scripts\" \"$(OPENMCL_SCRIPT)\"))

$(prefix)/%/lispbox-register.el: $(lisp)
	echo "(push (list '$(lisp) (list $(lisppath))) slime-lisp-implementations)" > $@
	if [ ! -z "$(license)" ]; \
	  then echo "(lispbox-install-lisp-license (list $(license)) \"$(*)\")" >> $@; \
	fi

ifeq ($(os),Darwin)
$(prefix)/Emacs.app/Contents/Info.plist: Info.plist $(emacs)
	cp Info.plist $(prefix)/Emacs.app/Contents/
endif

# Unpacking pre-built staging archives into prefix.

components := $(emacs) $(allegro) $(clisp) $(sbcl) $(slime) $(practicals) $(portableaserve)
ifeq ($(os),Darwin)
components += $(openmcl)
endif


$(components): %: staging-archives/%.tar.gz $(prefix)
	cat $< | (cd $(prefix); gzip -cdq | tar xf -)

$(sbcl): staging-archives/$(sbcl).tar.gz $(prefix)
	cat $< | (cd $(prefix); gzip -cdq | tar xf -)

# Building staging archives if necessary

staging-archives/$(emacs).tar.gz:          makefile := GNUmakefile.emacs
staging-archives/$(allegro).tar.gz:        makefile := GNUmakefile.allegro
staging-archives/$(clisp).tar.gz:          makefile := GNUmakefile.clisp
staging-archives/$(openmcl).tar.gz:        makefile := GNUmakefile.openmcl
staging-archives/$(sbcl).tar.gz:           makefile := GNUmakefile.sbcl
staging-archives/$(slime).tar.gz:          makefile := GNUmakefile.slime
staging-archives/$(practicals).tar.gz:     makefile := GNUmakefile.practicals
staging-archives/$(portableaserve).tar.gz: makefile := GNUmakefile.portableaserve

staging-archives/%.tar.gz:
	$(MAKE) -f $(makefile) THING=$*

### EMACS ###

emacs: $(emacs)

slime-docs: emacs
	cd $(prefix)/$(slime)/doc; \
	$(MAKE) infodir=$(prefix)/$(emacs)/info install-info


