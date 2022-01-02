Distribution: CentOS
Group: Applications
License: BSD
Name: tableau_%(cat VERSION.RPM)
Packager: Alexis Megas
Release: 1
Source: TableauSrc.tar.gz
Summary: Tableau
Vendor: Alexis Megas
Version: %(cat VERSION.RPM)

%define _unpackaged_files_terminate_build 0

%build
if [ "%{_debug}" == "debug" ]; then
   make -j $(nproc) debug && make install
else
   make -j $(nproc) install
fi

%clean

%description
Tableau

%files
/usr/local/tableau/Data
/usr/local/tableau/Desktop
/usr/local/tableau/Documentation
/usr/local/tableau/Icons
/usr/local/tableau/bin
/usr/local/tableau/lib

%install
mkdir -p $RPM_BUILD_ROOT/usr/local/tableau/Data
mkdir -p $RPM_BUILD_ROOT/usr/local/tableau/Desktop
mkdir -p $RPM_BUILD_ROOT/usr/local/tableau/Documentation
mkdir -p $RPM_BUILD_ROOT/usr/local/tableau/Icons
mkdir -p $RPM_BUILD_ROOT/usr/local/tableau/bin

if [ -e Qwt/Library/64 ]; then
    mkdir -p $RPM_BUILD_ROOT/usr/local/tableau/lib/Qwt/64
fi

cp -p Documentation/Ecma-262.pdf $RPM_BUILD_ROOT/usr/local/tableau/Documentation
cp -p Documentation/Tableau.1 $RPM_BUILD_ROOT/usr/local/tableau/Documentation
cp -p Source/UI/Documentation/*.pdf $RPM_BUILD_ROOT/usr/local/tableau/Documentation
cp -p Source/UI/Icons/tableau.jpg $RPM_BUILD_ROOT/usr/local/tableau/Icons
cp -p TO-DO $RPM_BUILD_ROOT/usr/local/tableau/Documentation
cp -pr Build/bin $RPM_BUILD_ROOT/usr/local/tableau
cp -pr Build/lib $RPM_BUILD_ROOT/usr/local/tableau
cp -pr Data/Databases $RPM_BUILD_ROOT/usr/local/tableau/Data
cp -pr Data/Displays $RPM_BUILD_ROOT/usr/local/tableau/Data
cp -pr Desktop $RPM_BUILD_ROOT/usr/local/tableau

if [ -e Qwt/Library/64 ]; then
    cp -pr Qwt/Library/64 $RPM_BUILD_ROOT/usr/local/tableau/lib/Qwt
fi

%post

%pre

%prep
%setup -c -q

%postun
if [ $1 -eq 0 ]; then
    rmdir --ignore-fail-on-non-empty /usr/local/tableau
fi
