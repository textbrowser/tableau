macx {
QMAKE_CXXFLAGS_RELEASE += -Wall \
                          -Wcast-align \
                          -Wcast-qual \
                          -Wextra \
                          -Woverloaded-virtual \
                          -Wpointer-arith \
                          -Wstack-protector \
                          -Wstrict-overflow=5 \
                          -Wundef \
                          -fPIC \
                          -fstack-protector-all \
                          -fwrapv \
                          -mtune=generic \
                          -pedantic \
                          -std=c++11
} else:unix {
QMAKE_CXXFLAGS_RELEASE += -Wall \
                          -Wcast-align \
                          -Wcast-qual \
                          -Wextra \
                          -Wlogical-op \
                          -Wno-class-memaccess \
                          -Wno-deprecated-copy \
                          -Woverloaded-virtual \
                          -Wpointer-arith \
                          -Wstack-protector \
                          -Wstrict-overflow=5 \
                          -Wundef \
                          -fPIC \
                          -fstack-protector-all \
                          -fwrapv \
                          -pie
} else:win32 {
QMAKE_CXXFLAGS_RELEASE += -Wall \
                          -Wcast-align \
                          -Wcast-qual \
                          -Werror \
                          -Wextra \
                          -Wno-class-memaccess \
                          -Woverloaded-virtual \
                          -Wpointer-arith \
                          -Wstrict-overflow=5 \
                          -Wundef \
                          -fwrapv \
                          -mtune=generic \
                          -pedantic \
                          -pie \
                          -std=c++11
}

greaterThan(QT_MAJOR_VERSION, 4) {
QMAKE_CXXFLAGS_RELEASE += -std=c++11
}
