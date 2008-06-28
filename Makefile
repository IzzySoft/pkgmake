# Makefile for pkgmake
# $Id$

DESTDIR=
INSTALL=install
INSTALL_PROGRAM=$(INSTALL)
INSTALL_DATA=$(INSTALL) -m 644
prefix=/usr/local
exec_prefix=$(prefix)
bindir=$(exec_prefix)/bin
datarootdir=$(prefix)/share
datadir=$(datarootdir)
docdir=$(datarootdir)/doc/pkgmake
sysconfdir=/etc/pkgmake
mandir=$(datarootdir)/man
man5dir=$(mandir)/man5
man8dir=$(mandir)/man8

RPMROOT=$(DESTDIR)/usr/src/rpm
DEBLINK=$(DESTDIR)/usr/src/debian
SPECDIR=$(RPMROOT)/SPECS

install: installdirs
	$(INSTALL_DATA) -c pkgmake.conf spec2arch.conf $(DESTDIR)$(sysconfdir)
	$(INSTALL_DATA) -c version autosect $(DESTDIR)$(sysconfdir)
	$(INSTALL) -c pkgmake spec2arch $(DESTDIR)$(bindir)
	$(INSTALL_DATA) -c doc/* $(DESTDIR)$(docdir)
	gzip man/*
	$(INSTALL_DATA) -c man/*.5* $(DESTDIR)$(man5dir)
	$(INSTALL_DATA) -c man/*.8* $(DESTDIR)$(man8dir)
	$(INSTALL_DATA) -c tpl/* $(SPECDIR)

uninstall:
	rm -f $(DESTDIR)$(sysconfdir)
	rm -f $(DESTDIR)$(bindir)/pkgmake
	rm -rf $(DESTDIR)$(docdir)
	rm -f $(DESTDIR)$(man5dir)/pkgmake.*
	rm -f $(DESTDIR)$(man5dir)/spec2arch.*
	rm -f $(DESTDIR)$(man8dir)/pkgmake.*
	rm -f $(DESTDIR)$(man8dir)/spec2arch.*

installdirs:
	# Generate all required target directories (due to DESTDIR, i.e. all)
	mkdir -p $(DESTDIR)$(docdir)
	if [ ! -d $(SPECDIR) ]; then mkdir -p $(SPECDIR); fi
	if [ ! -d $(DESTDIR)$(bindir) ]; then mkdir -p $(DESTDIR)$(bindir); fi
	if [ ! -d $(DESTDIR)$(sysconfdir) ]; then mkdir -p $(DESTDIR)$(sysconfdir); fi
	if [ ! -d $(DESTDIR)$(man5dir) ]; then mkdir -p $(DESTDIR)$(man5dir); fi
	if [ ! -d $(DESTDIR)$(man8dir) ]; then mkdir -p $(DESTDIR)$(man8dir); fi
	if [ ! -e $(DEBLINK) ]; then if [ -e $(RPMROOT) ]; then ln -s $(RPMROOT) $(DEBLINK); fi; fi
