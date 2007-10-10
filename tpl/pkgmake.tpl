Summary: pkgmake - create RPM spec files and build *.rpm/*.deb packages
Name: __NAME__
Version: __VERSION__
Release: __RELEASE__
License: __LICENSE__
Group: __GROUP__
Source: __NAME__-%{version}.tar.gz
Vendor: Andreas Itzchak Rehberg <devel@izzysoft.de>
URL: http://www.izzysoft.de/
Packager: __PACKAGER__
BuildArch: noarch
BuildRoot: %{_tmppath}/%{name}-root
Requires: findutils
Requires: sed
Requires: tar
__PROVIDES__
#
AutoReqProv:   no

%if %{REDHAT}
  %define RPMDIR /usr/src/redhat
%else
  %define RPMDIR /usr/src/rpm
%endif

%description
pkgmake is just a simple shell script to create RPM *.spec files and per
default (which is optionally) calls the packager rpmbuild/debbuild to create
the package. For not-too-complex packages, a single spec template can serve
for all packages to build, since most information (as e.g. packager, target
architecture) do not change (and thus are hold as default values in the
configuration) - while others (like package name and version) can be passed
to the script on the command line.

Its target is to be simple to use, and save the developer from the need to
study all the details and specifications concerning the package management
with RPM and Debian. Instead, in most cases you will be able to build the RPM
and the DEB package with the same SPEC file and configuration.

%prep
#%setup -q -n %{name}-%{version}
%setup 

%build

%install
make DESTDIR="${RPM_BUILD_ROOT}" prefix=/usr install
%if %{REDHAT}
  mv ${RPM_BUILD_ROOT}/usr/src/rpm ${RPM_BUILD_ROOT}%{RPMDIR}
%endif
rm -rf ${RPM_BUILD_ROOT}/usr/src/debian
#cp -pr ${RPM_BUILD_ROOT} /usr/src/debian/SPECS

%pre

%clean
[ "$RPM_BUILD_ROOT" != "/" ] && rm -rf $RPM_BUILD_ROOT

%post
%if %{REDHAT}
  if [ ! -e /usr/src/debian ]; then ln -s %{RPMDIR} /usr/src/debian; fi
%else
  if [ ! -e /usr/src/debian ]; then ln -s /usr/src/rpm /usr/src/debian; fi
%endif

%preun

%postun

%files
%defattr(-,root,root)
%doc /usr/share/doc/pkgmake
%config /etc/pkgmake/pkgmake.conf
%attr(755,root,root) /usr/bin/pkgmake
/etc/pkgmake/*
/usr/share/man/man5/pkgmake.conf.5*
/usr/share/man/man5/pkgmake.tpl.5*
/usr/share/man/man8/pkgmake.8*
%if %{REDHAT}
%{RPMDIR}/SPECS/alldirs.tpl
%{RPMDIR}/SPECS/make.tpl
%{RPMDIR}/SPECS/pkgmake.tpl
%else
/usr/src/rpm/SPECS/alldirs.tpl
/usr/src/rpm/SPECS/make.tpl
/usr/src/rpm/SPECS/pkgmake.tpl
%endif

%changelog
