#!/bin/bash

# Alexis Megas.

if [ ! -x /usr/bin/dpkg-deb ]
then
    echo "Are we on Debian?"
    exit 1
fi

mkdir -p ./usr/local/tableau/current/Desktop
mkdir -p ./usr/local/tableau/current/Documentation
mkdir -p ./usr/local/tableau/current/bin
mkdir -p ./usr/local/tableau/current/lib
mkdir -p ./usr/local/tableau/current/lib/Qwt/64
cp -p Desktop/*.desktop ./usr/local/tableau/current/Desktop/.
cp -p Documentation/Ecma-262.pdf ./usr/local/tableau/current/Documentation/.
cp -p Documentation/Tableau.1 ./usr/local/tableau/current/Documentation/.
cp -p Qwt/Library/64/Qt5/Debian/lib* ./usr/local/tableau/current/lib/Qwt/64/.
cp -p Source/*/lib* ./usr/local/tableau/current/lib/.
cp -p Source/UI/Documentation/*.pdf ./usr/local/tableau/current/Documentation/.
cp -p Source/UI/Tableau ./usr/local/tableau/current/bin/.
cp -p Source/UI/Tableau.bash ./usr/local/tableau/current/bin/.
cp -pr Data ./usr/local/tableau/current/.
cp -pr Source/UI/Icons ./usr/local/tableau/current/.
rm -f ./usr/local/tableau/current/Icons/*.ico
rm -f ./usr/local/tableau/current/Icons/*.qrc
rm -f ./usr/local/tableau/current/Icons/*.rc
mkdir -p tableau-debian/usr/local
mkdir -p tableau-debian/usr/share/applications
cp -p ./Desktop/*.desktop tableau-debian/usr/share/applications/.
cp -pr ./DEBIAN tableau-debian/.
cp -r ./usr/local/tableau tableau-debian/usr/local/.
fakeroot dpkg-deb --build tableau-debian Tableau-2022.01.10_amd64.deb
rm -fr ./usr
rm -fr tableau-debian
