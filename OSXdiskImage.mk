include GNUmakefile.vars

rootdir    := $(TOP)/lispbox-$(LISPBOX_VERSION)
builddir   := $(TOP)
version    := $(LISPBOX_VERSION)
title      := Lispbox

compressed_size = $(shell du -s $(rootdir) | cut -f1)
sectors         = $(shell echo 3.0*$(compressed_size) | bc)
mount_location  := `hdid -nomount $(builddir)/LispboxRW.dmg | grep HFS | cut -f1`

all: $(NAME)

clean:
	rm -f $(builddir)/lispbox-$(LISPBOX_VERSION).dmg
	rm -rf $(TOP)/staging/
	rm -f $(builddir)/LispboxRW.dmg

$(NAME): $(builddir)/lispbox-$(LISPBOX_VERSION).dmg
	cp $< $@

$(builddir)/lispbox-$(LISPBOX_VERSION).dmg:
	if [ -e /Volumes/Lispbox ]; then hdiutil eject $(mount_location); fi
	hdiutil create -ov $(builddir)/LispboxRW -sectors $(sectors)
	/sbin/newfs_hfs -v Lispbox $(mount_location)
	hdiutil eject $(mount_location)
	hdid $(builddir)/LispboxRW.dmg
	df
	cp -R $(rootdir) /Volumes/Lispbox
	hdiutil eject $(mount_location)
	hdiutil resize $(builddir)/LispboxRW.dmg -sectors min
	hdiutil convert $(builddir)/LispboxRW.dmg -format UDCO -o $(builddir)/lispbox-$(LISPBOX_VERSION).dmg
