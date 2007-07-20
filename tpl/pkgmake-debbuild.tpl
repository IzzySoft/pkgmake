Summary: pkgmake - create RPM spec files and build *.rpm/*.deb packages
Name: __NAME__
Version: __VERSION__
Release: __RELEASE__
License: __LICENSE__
Group: universe/Development
Source: __NAME__-%{version}.tar.gz
Vendor: Andreas Itzchak Rehberg <devel@izzysoft.de>
URL: http://www.izzysoft.de/
Packager: __PACKAGER__
BuildArch: noarch
BuildRoot: %{_tmppath}/%{name}-root
__REQUIRES__
__PROVIDES__
#
AutoReqProv:   no

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
[ "$RPM_BUILD_ROOT" != "/" ] && rm -rf $RPM_BUILD_ROOT
mkdir -p "${RPM_BUILD_ROOT}/etc"
mkdir -p "${RPM_BUILD_ROOT}/usr/bin"
mkdir -p "${RPM_BUILD_ROOT}/usr/share/man/man5"
mkdir -p "${RPM_BUILD_ROOT}/usr/share/man/man8"
make DESTDIR="${RPM_BUILD_ROOT}" install
rm -rf ${RPM_BUILD_ROOT}/usr/src/debian
mv ${RPM_BUILD_ROOT}/usr/share/doc/pkgmake/* ${RPM_BUILD_ROOT}/usr/share/doc/

%pre

%clean
[ "$RPM_BUILD_ROOT" != "/" ] && rm -rf $RPM_BUILD_ROOT

%post
[ ! -h /usr/src/debian ] && [ ! -d /usr/src/debian ] && ln -s /usr/src/rpm /usr/src/debian

%preun

%postun

%files
%defattr(-,root,root)
%doc pkgmake.txt
%doc LICENSE
%doc specfile.txt
%doc history
%config /etc/pkgmake.conf
%attr(755,root,root) /usr/bin/pkgmake
/usr/share/man/man5/pkgmake.conf.5
/usr/share/man/man5/pkgmake.tpl.5
/usr/share/man/man8/pkgmake.8
/usr/src/rpm/SPECS/alldirs.tpl
/usr/src/rpm/SPECS/make.tpl

%changelog
