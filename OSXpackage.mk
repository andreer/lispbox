include GNUmakefile.vars

packagedir := $(TOP)/Lispbox.pkg
rootdir    := $(TOP)/lispbox-$(LISPBOX_VERSION)
builddir   := $(TOP)
version    := $(LISPBOX_VERSION)
title      := Lispbox

files := $(addprefix $(packagedir)/Contents/Resources/Lispbox., pax.gz bom sizes)
files += $(addprefix $(packagedir)/Contents/Resources/, English.lproj/Lispbox.info License.txt ReadMe.txt)
files += $(packagedir)/Contents/PkgInfo

compressed_size = $(shell du -s $(packagedir) | cut -f1)
#sectors         = $(shell echo 2.1*$(compressed_size) | bc)
sectors         = $(shell echo 3.0*$(compressed_size) | bc)
mount_location  := `hdid -nomount $(builddir)/LispboxRW.dmg | grep HFS | cut -f1`

all: $(NAME)

clean:
	rm -rf $(packagedir)
	rm -f $(builddir)/LispboxInstaller.dmg
	rm -rf $(TOP)/staging/
	rm -f $(builddir)/LispboxRW.dmg

$(NAME): $(builddir)/LispboxInstaller.dmg
	cp $< $@

$(packagedir)/Contents/Resources/English.lproj:
	mkdir -p $@

$(packagedir)/Contents/PkgInfo:
	echo -n 'pmkrpkg1' > $@

$(packagedir)/Contents/Resources/License.txt:
	cp COPYING $@

$(packagedir)/Contents/Resources/ReadMe.txt:
	cp README $@

$(packagedir)/Contents/Resources/English.lproj/Lispbox.info: $(packagedir)/Contents/Resources/English.lproj
	echo "Title $(title)"                          > $@
	echo "Version $(version)"                      >> $@
	echo "Description Install $(title) $(version)" >> $@
	echo 'DefaultLocation /'                       >> $@
	echo 'DeleteWarning'                           >> $@
	echo 'NeedsAuthorization YES'                  >> $@
	echo 'Required NO'                             >> $@
	echo 'Relocatable NO'                          >> $@
	echo 'RequiresReboot NO'                       >> $@
	echo 'UseUserMask NO'                          >> $@
	echo 'OverwritePermissions NO'                 >> $@
	echo 'InstallFat NO'                           >> $@

$(packagedir)/Contents/Resources/Lispbox.pax.gz: $(packagedir)/Contents/Resources/Lispbox.pax
	gzip $<

$(packagedir)/Contents/Resources/Lispbox.pax: $(TOP)/staging/Applications/Lispbox
	mkdir -p $(dir $@)
	cd $(TOP)/staging; pax -w -f $@ .

$(packagedir)/Contents/Resources/Lispbox.bom: $(TOP)/staging/Applications/Lispbox
	mkbom $(TOP)/staging $@

$(TOP)/staging/Applications/Lispbox:
	mkdir -p $(dir $@)
	chown -R root:admin $(rootdir)
	cp -R $(rootdir) $@
	find $@/$(LISPBOX_LISP) \( -name '*.o' -o -name '*.fasl' -o -name '*.so' \) -exec touch {} \;

$(packagedir)/Contents/Resources/Lispbox.sizes: $(packagedir)/Contents/Resources/License.txt $(packagedir)/Contents/Resources/ReadMe.txt
	echo "NumFiles $(shell du -a $(rootdir) | wc -l)" > $@
	echo "InstalledSize $(shell du -s $(rootdir) | cut -f1)" >> $@
	echo "CompressedSize $(compressed_size)" >> $@

$(builddir)/LispboxInstaller.dmg: $(files)
	if [ -e /Volumes/Lispbox ]; then hdiutil eject $(mount_location); fi
	hdiutil create -ov $(builddir)/LispboxRW -sectors $(sectors)
	/sbin/newfs_hfs -v Lispbox $(mount_location)
	hdiutil eject $(mount_location)
	hdid $(builddir)/LispboxRW.dmg
	df
	chown -R root:admin $(packagedir)
	cp -R $(packagedir) /Volumes/Lispbox
	hdiutil eject $(mount_location)
	hdiutil resize $(builddir)/LispboxRW.dmg -sectors min
	hdiutil convert $(builddir)/LispboxRW.dmg -format UDRO -o $(builddir)/LispboxInstaller.dmg



