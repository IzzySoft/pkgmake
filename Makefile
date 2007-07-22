# Makefile for pkgmake
# $Id$

DESTDIR=
BINDIR=$(DESTDIR)/usr/bin
DOCDIR=$(DESTDIR)/usr/share/doc/pkgmake
CONFDIR=$(DESTDIR)/etc
MANDIR=$(DESTDIR)/usr/share/man
RPMROOT=$(DESTDIR)/usr/src/rpm
DEBLINK=$(DESTDIR)/usr/src/debian
SPECDIR=$(RPMROOT)/SPECS
INSTALL=install

install:
	mkdir -p $(DOCDIR)
	mkdir -p $(SPECDIR)
	$(INSTALL) -c -m 755 pkgmake.conf $(CONFDIR)
	$(INSTALL) -c -m 755 pkgmake $(BINDIR)
	$(INSTALL) -c -m 644 doc/* $(DOCDIR)
	$(INSTALL) -c -m 644 man/*.5 $(MANDIR)/man5
	$(INSTALL) -c -m 644 man/*.8 $(MANDIR)/man8
	$(INSTALL) -c -m 644 tpl/* $(SPECDIR)
	[ !-f $(DEBLINK) ] && [ ! -h $(DEBLINK) ] && ln -s $(RPMROOT) $(DEBLINK)
