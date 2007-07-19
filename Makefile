# Makefile for pkgmake
# $Id$

DESTDIR=
OWNER=root
GROUP=root
BINDIR=$(DESTDIR)/usr/bin
DOCDIR=$(DESTDIR)/usr/share/doc/pkgmake
CONFDIR=$(DESTDIR)/etc
MANDIR=$(DESTDIR)/usr/share/man
RPMROOT=$(DESTDIR)/usr/src/redhat
DEBLINK=$(DESTDIR)/usr/src/debian
SPECDIR=$(RPMROOT)/SPECS
INSTALL=install

install:
	mkdir -p $(DOCDIR)
	mkdir -p $(SPECDIR)
	$(INSTALL) -c -o $(OWNER) -g $(GROUP) -m 755 pkgmake.conf $(CONFDIR)
	$(INSTALL) -c -o $(OWNER) -g $(GROUP) -m 755 pkgmake $(BINDIR)
	$(INSTALL) -c -o $(OWNER) -g $(GROUP) -m 644 doc/* $(DOCDIR)
	$(INSTALL) -c -o $(OWNER) -g $(GROUP) -m 644 man/*.5 $(MANDIR)/man5
	$(INSTALL) -c -o $(OWNER) -g $(GROUP) -m 644 man/*.8 $(MANDIR)/man8
	$(INSTALL) -c -o $(OWNER) -g $(GROUP) -m 644 tpl/* $(SPECDIR)
	ln -s $(RPMROOT) $(DEBLINK)
