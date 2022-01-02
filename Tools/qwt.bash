#!/bin/bash

# Alexis Megas.

if [ -z "$(ls ./Qwt/Features 2>/dev/null)" ] ||
   [ -z "$(ls ./Qwt/Include 2>/dev/null)" ] ||
   [ -z "$(ls ./Qwt/Library 2>/dev/null)" ]; then
    echo "Please issue make qwt from top-level source directory."
    exit 1
fi

# Qt 4.8.7 or Qt 5.x!

qmake="/usr/local/Trolltech/Qt-4.8.7/bin/qmake"
qt5=0

if [ ! -e "$qmake" ]; then
    qmake="$(which qmake 2>/dev/null)"
fi

if [ ! -e "$qmake" ]; then
    qmake="$(which qmake-qt5 2>/dev/null)"
fi

if [ -z "$qmake" ]; then
    echo "Cannot discover Qt."
    exit 1
else
    echo $qmake -v

    if [ ! -z "$($qmake -v 2>/dev/null | grep 5\.)" ]; then
	echo "Building using Qt 5!"
	qt5=1
    fi
fi

git=$(which git)

if [ -z "$git" ]; then
    echo "Cannot locate git executable."
    exit 1
fi

user=$USER

if [ ! -e /tmp/qwt-code.$user ]; then
    $git clone https://git.code.sf.net/p/qwt/git /tmp/qwt-code.$user

    if [ ! $? -eq 0 ]; then
	echo "git clone failure."
	exit 1
    fi
else
    echo "The directory /tmp/qwt-code.$user exists. Continuing."
fi

pwd=$(pwd)
cd /tmp/qwt-code.$user

if [ ! $? -eq 0 ]; then
    echo "Cannot change directory to /tmp/qwt-code.$user/."
    exit 1
fi

unset QTDIR
unset QTINC
unset QTLIB
unset QT_PLUGIN_PATH
make distclean 2>/dev/null
$qmake -o Makefile qwt.pro

if [ ! $? -eq 0 ]; then
    echo "qmake failure."
    exit 1
fi

make -j 5

if [ ! $? -eq 0 ]; then
    echo "Build failure. Continuing."
fi

mkdir -p $pwd/Qwt/Features
cp *.prf *.pri $pwd/Qwt/Features/.

if [ ! $? -eq 0 ]; then
    echo "Cannot copy prf and pri files to Qwt/Features/."
    exit 1
fi

mkdir -p $pwd/Qwt/Include
cp ./classincludes/Qwt* $pwd/Qwt/Include/.

if [ ! $? -eq 0 ]; then
    echo "Cannot copy classincludes files to Qwt/Include/."
    exit 1
fi

bits=32

if [ "$(uname -p)" == "x86_64" ]; then
    bits=64
fi

qt5dir=""

if [ $qt5 -eq 1 ]; then
    if [ ! -z "$(cat /proc/version 2>/dev/null | grep -i centos)" ]; then
	qt5dir="$pwd/Qwt/Library/64/Qt5/CentOS"
    else
	qt5dir="$pwd/Qwt/Library/64/Qt5/Debian"
    fi

    mkdir -p $qt5dir
    cp ./lib/libqwt*.so* "$qt5dir/."
else
    mkdir -p $pwd/Qwt/Library/$bits
    cp ./lib/libqwt*.so* $pwd/Qwt/Library/$bits/.
fi

if [ ! $? -eq 0 ]; then
    if [ $qt5 -eq 1 ]; then
	echo "Cannot copy library files to $qt5dir/."
    else
	echo "Cannot copy library files to Qwt/Library/$bits/."
    fi

    exit 1
fi

mkdir -p $pwd/Qwt/Include
cp ./src/*.h $pwd/Qwt/Include/.

if [ ! $? -eq 0 ]; then
    echo "Cannot copy include files to Qwt/Include/."
    exit 1
fi

rm -fr /tmp/qwt-code.$user
echo "Qwt prepared!"
exit 0
