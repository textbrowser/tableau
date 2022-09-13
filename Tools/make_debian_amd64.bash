#!/usr/bin/env bash

# Alexis Megas.

if [ ! -x /usr/bin/dpkg-deb ]
then
    echo "Are we on Debian?"
    exit 1
fi

mkdir -p ./usr/local/tableau/Desktop
mkdir -p ./usr/local/tableau/Documentation
mkdir -p ./usr/local/tableau/bin
mkdir -p ./usr/local/tableau/lib
mkdir -p ./usr/local/tableau/lib/Qwt/64
cp -p Desktop/*.desktop ./usr/local/tableau/Desktop/.
cp -p Documentation/Ecma-262.pdf ./usr/local/tableau/Documentation/.
cp -p Documentation/Tableau.1 ./usr/local/tableau/Documentation/.
cp -p Qwt/Library/64/Qt5/Debian/lib* ./usr/local/tableau/lib/Qwt/64/.
cp -p Source/*/lib* ./usr/local/tableau/lib/.
cp -p Source/UI/Documentation/*.pdf ./usr/local/tableau/Documentation/.
cp -p Source/UI/Tableau ./usr/local/tableau/bin/.
cp -p Source/UI/Tableau.bash ./usr/local/tableau/bin/.
cp -pr Data ./usr/local/tableau/.
cp -pr Source/UI/Icons ./usr/local/tableau/.
rm -f ./usr/local/tableau/Icons/*.ico
rm -f ./usr/local/tableau/Icons/*.qrc
rm -f ./usr/local/tableau/Icons/*.rc
mkdir -p tableau-debian/usr/local
mkdir -p tableau-debian/usr/share/applications
cp -p ./Desktop/*.desktop tableau-debian/usr/share/applications/.
cp -pr ./DEBIAN tableau-debian/.
cp -r ./usr/local/tableau tableau-debian/usr/local/.
fakeroot dpkg-deb --build tableau-debian Tableau-2022.12.25_amd64.deb
rm -fr ./usr
rm -fr tableau-debian
