win32 {
QMAKE_CXXFLAGS_RELEASE += -m32
}
else {
}

QMAKE_DISTCLEAN += -fr temp .qmake.cache .qmake.stash
QMAKE_LFLAGS_RPATH =
QMAKE_STRIP = echo
VERSION = "$$cat(VERSION)"
