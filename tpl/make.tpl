Summary: __SUMMARY__
Name: __NAME__
Version: __VERSION__
Release: __RELEASE__
License: __LICENSE__
Group: __GROUP__
Source: __NAME__-%{version}.tar.gz
Vendor: __VENDOR__
__VENDORURL__
Packager: __PACKAGER__
BuildArch: __BUILDARCH__
BuildRoot: %{_tmppath}/%{name}-root
__REQUIRES__
__PROVIDES__
#
AutoReqProv:   no

%description
__DESCRIPTION__

%prep
#%setup -q -n %{name}-%{version}
%setup 

%build

%install
[ "$RPM_BUILD_ROOT" != "/" ] && rm -rf $RPM_BUILD_ROOT
mkdir "$RPM_BUILD_ROOT"
pushd $RPM_BUILD_DIR/%{name}-%{version}
cp -rp * $RPM_BUILD_ROOT
popd

%pre

%clean
[ "$RPM_BUILD_ROOT" != "/" ] && rm -rf $RPM_BUILD_ROOT

%post

%preun

%postun

%files
%defattr(-,www-data,www-data)
# Add your files here, e.g.:
#%doc doc/readme.txt
#%config /etc/sample.conf
#%attr(644,root,root) /some/file.ext
# This will include /some/dir and all files/directories below it
#/some/dir

%changelog
