#!/usr/bin/env bash

# Alexis Megas.

# Download some dependencies for Windows.
# Must be executed in the top-level source directory.

# OpenSSL 1.1.1

openssl=mingw-w64-i686-openssl-1.1.1.q-1-any.pkg.tar.zst

rm -f $openssl
wget --output-document=$openssl \
     --progress=bar \
     https://repo.msys2.org/mingw/i686/$openssl

if [ -r "$openssl" ]; then
    tar -I zstd -vxf $openssl
    cp mingw32/bin/libcrypto-1_1.dll OpenSSL/Windows/32/.
    cp mingw32/bin/libssl-1_1.dll OpenSSL/Windows/32/.
    chmod +w,-x OpenSSL/Windows/32/*.dll
    rm -f $openssl
    rm -fr .BUILDINFO .MTREE .PKGINFO mingw32
else
    echo "Cannot read $openssl."
fi
