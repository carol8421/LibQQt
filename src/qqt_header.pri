#-------------------------------------------------
#
# Project created by QtCreator 2017-10-08T23:30:20
#
#-------------------------------------------------
# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked as deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

#################################################################
##project version
#################################################################
unix:VERSION            = 1.2.0

#################################################################
##definition and configration
#################################################################

##Qt version
QT += core gui network sql xml
greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

#You need define a env variable QKIT=XX
#处理文件内平台小差异
#EMBEDDED __EMBEDDED_LINUX__
#MIPS __MIPS_LINUX__
#ARM __ARM_LINUX__
#LINUX __LINUX__
#LINUX64 __LINUX64__
#WIN __WIN__
#WIN64 __WIN64__
#macOS __DARWIN__
#Android __ANDROID__
#ANDROIDX86 __ANDROIDX86__
##target arch type
QKIT_ = $$(QKIT)
message(Build $${TARGET} to $${QKIT_})
equals(QKIT_, EMBEDDED) {
    #embedded common macro
    DEFINES += __EMBEDDED_LINUX__
} else:equals(QKIT_, ARM32) {
    DEFINES += __EMBEDDED_LINUX__
    #arm32 private
    DEFINES += __ARM_LINUX__
} else:equals(QKIT_, MIPS32) {
    QT += multimedia
    DEFINES += __EMBEDDED_LINUX__
    #mips32 private
    DEFINES += __MIPS_LINUX__
} else:equals(QKIT_, LINUX) {
    DEFINES += __LINUX__
} else:equals(QKIT_, LINUX64) {
    DEFINES += __LINUX64__
} else:equals(QKIT_, WIN) {
    DEFINES += __WIN__
} else:equals(QKIT_, WIN64) {
    DEFINES += __WIN64__
} else:equals(QKIT_, macOS) {
    DEFINES += __DARWIN__
} else:equals(QKIT_, iOS) {
    DEFINES += __IOS__
} else:equals(QKIT_, iOSSimulator) {
    DEFINES += __IOS__
} else:equals(QKIT_, Android) {
    DEFINES += __ANDROID__
} else:equals(QKIT_, ANDROIDX86) {
    DEFINES += __ANDROID__
    #todo:no customplot word printer
}

#QMAKESPEC_NAME = $${QMAKESPEC}
#QMAKESPEC_NAME ~= s@^/.*/([^/]+)/?@\1@g
#QMAKESPECS = $${QMAKESPEC}
#QMAKESPECS ~= s:/[^/]*$::p
#message ($$QMAKESPEC_NAME $$QMAKESPECS)
#equals(QMAKESPEC_NAME, EMBEDDED) {
#    #embedded common macro
#    DEFINES += __EMBEDDED_LINUX__
#} else:equals(QMAKESPEC_NAME, *arm*) {
#    DEFINES += __EMBEDDED_LINUX__
#    #arm32 private
#    DEFINES += __ARM_LINUX__
#} else:equals(QMAKESPEC_NAME, *mips*) {
#    QT += multimedia
#    DEFINES += __EMBEDDED_LINUX__
#    #mips32 private
#    DEFINES += __MIPS_LINUX__
#} else:equals(QMAKESPEC_NAME, linux-g++-32) {
#    DEFINES += __LINUX__
#} else:equals(QMAKESPEC_NAME, linux-g++) {
#    DEFINES += __LINUX64__
#} else:equals(QMAKESPEC_NAME, win32-*) {
#    DEFINES += __WIN__
#} else:equals(QMAKESPEC_NAME, win64-*) {
#    DEFINES += __WIN64__
#} else:equals(QMAKESPEC_NAME, macx-ios-*) {
#    DEFINES += __IOS__
#} else:equals(QMAKESPEC_NAME, iOSSimulator) {
#    DEFINES += __IOS__
#} else:equals(QMAKESPEC_NAME, macx-*) {
#    DEFINES += __DARWIN__
#} else:equals(QMAKESPEC_NAME, android-*) {
#    DEFINES += __ANDROID__
#} else:equals(QMAKESPEC_NAME, ANDROIDX86) {
#    DEFINES += __ANDROID__
#    #todo:no customplot word printer
#}
# release open debug output
CONFIG(debug, debug|release) {
} else {
    DEFINES -= QT_NO_DEBUG_OUTPUT
}
#close win32 no using fopen_s warning
win32 {
    win32:DEFINES += _CRT_SECURE_NO_WARNINGS #fopen fopen_s
    #this three pragma cause errors
    #QMAKE_CXXFLAGS += /wd"4819" /wd"4244" /wd"4100"
}
#compatible old version QQt (deperated)
greaterThan(QT_MAJOR_VERSION, 4): DEFINES += __QT5__

#################################################################
##variables
#################################################################
CONFIG(debug, debug|release) {
    BUILD=Debug
} else {
    BUILD=Release
}
equals(QKIT_, MIPS32) {
    SYSNAME = Mips32
} else:equals(QKIT_, LINUX) {
    SYSNAME = Linux
} else:equals(QKIT_, LINUX64) {
    SYSNAME = Linux64
} else:equals(QKIT_, WIN) {
    SYSNAME = Windows
} else:equals(QKIT_, WIN64) {
    SYSNAME = Win64
} else:equals(QKIT_, macOS) {
    SYSNAME = MacOS
} else:equals(QKIT_, iOS) {
    SYSNAME = iOS
} else:equals(QKIT_, iOSSimulator) {
    SYSNAME = iOS-simulator
} else:equals(QKIT_, Android) {
    SYSNAME = Android
} else:equals(QKIT_, ANDROIDX86) {
    SYSNAME = Android_x86
}
message(Build $${TARGET} at $${QT_VERSION} $${SYSNAME} $${BUILD})
message(Build $${TARGET} on $${QMAKE_HOST.os})

################################################################
##build cache
################################################################
OBJECTS_DIR = obj
MOC_DIR = obj/moc.cpp
UI_DIR = obj/ui.h
RCC_DIR = qrc
DESTDIR = bin

################################################################
##QQt Functions Macro
################################################################
#You need switch these more macro according to your needs.
#if you use qextserialport, open the annotation
#suggest: Qt5 use factory-packed, Qt4 use forming Qt5, extra use this.
#DEFINES += __QEXTSERIALPORT__
#if compiler QtSerialPort module manual, note this line is a good idea. default: qt4 qextserialport
lessThan(QT_MAJOR_VERSION, 5): DEFINES += __QEXTSERIALPORT__
#to ios, use qextserialport
contains (DEFINES, __IOS__): DEFINES += __QEXTSERIALPORT__
#android qt5 support serialport default?
contains (DEFINES, __QEXTSERIALPORT__) {
    CONFIG += thread
    unix:DEFINES += _TTY_POSIX_
    win32:DEFINES += _TTY_WIN_
    message ( __QEXTSERIALPORT__ Defined in $${TARGET})
} else {
    greaterThan(QT_MAJOR_VERSION, 4): QT += serialport
    lessThan(QT_MAJOR_VERSION, 5): CONFIG += serialport
    unix {
        DEFINES += _TTY_POSIX_
    } else {
        DEFINES += _TTY_WIN_
    }
}
#if you use qtbluetooth, open this annotation
DEFINES += __BLUETOOTH__
#if you compiler QtBluetooth module manual, note this line is a good idea. default qt4 don't use bluetooth
lessThan(QT_MAJOR_VERSION, 5): DEFINES -= __BLUETOOTH__
contains (DEFINES, __BLUETOOTH__) {
    greaterThan(QT_MAJOR_VERSION, 4): QT += bluetooth
    lessThan(QT_MAJOR_VERSION, 5): CONFIG += bluetooth
}
#if you use QR encode, open this annotation
DEFINES += __QRENCODE__
#if you use C++11, open this annotation. suggest: ignore
#DEFINES += __CPP11__
contains (DEFINES, __CPP11__) {
    #macOS gcc Qt4.8.7
    #qobject.h fatal error: 'initializer_list' file not found,
    #Qt4.8.7 can't support c++11 features
    #QMAKE_CXXFLAGS += "-std=c++11"
    #QMAKE_CXXFLAGS += "-std=c++0x"

    #below: gcc version > 4.6.3
    #Open this Config, Why in Qt4 works? see qmake config auto ignored this feature.
    #In Qt5? don't need open this config, qmake auto add c++11 support on linux plat.
    #on windows mingw32? need test
    #CONFIG += c++11

    #compile period
    #LibQQt need c++11 support. Please ensure your compiler version.
    #LibQQt used override identifier
    #lambda also need c++11
}
#if you use qcustomplot, open this annotation
#need print support
DEFINES += __CUSTOMPLOT__
#if you use printsupport , open this annotation
DEFINES += __PRINTSUPPORT__
#ios android can't support this function now
equals(QKIT_, iOS):DEFINES -= __CUSTOMPLOT__
equals(QKIT_, iOS):DEFINES -= __PRINTSUPPORT__
equals(QKIT_, Android):DEFINES -= __CUSTOMPLOT__
equals(QKIT_, Android):DEFINES -= __PRINTSUPPORT__
contains (DEFINES, __PRINTSUPPORT__) {
    greaterThan(QT_MAJOR_VERSION, 4): QT += printsupport
}

#if you use QWebSocketSupport , open this annotation
#DEFINES += __WEBSOCKETSUPPORT__
equals(QKIT_, macOS):DEFINES += __WEBSOCKETSUPPORT__
contains (DEFINES, __WEBSOCKETSUPPORT__) {
    #QSslError not found, you need recompiler Qt4
    #TODO: QT += webkit
}


##################################################################
##include directories
##################################################################
INCLUDEPATH += $$PWD
INCLUDEPATH += $$PWD/core
INCLUDEPATH += $$PWD/customplot
# c support
INCLUDEPATH += $$PWD/dmmu
INCLUDEPATH += $$PWD/frame
INCLUDEPATH += $$PWD/gui
INCLUDEPATH += $$PWD/multimedia
INCLUDEPATH += $$PWD/network
INCLUDEPATH += $$PWD/network/qextserialport
INCLUDEPATH += $$PWD/pluginwatcher
INCLUDEPATH += $$PWD/printsupport
INCLUDEPATH += $$PWD/sql
INCLUDEPATH += $$PWD/widgets
INCLUDEPATH += $$PWD/exquisite
# c support
INCLUDEPATH += $$PWD/qrencode