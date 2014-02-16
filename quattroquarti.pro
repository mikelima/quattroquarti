# The name of your app.
isEmpty(VERSION) {
   VERSION = "x.y"
}

isEmpty(TARGET) {
    TARGET = "quattroquarti"
}

CONFIG += sailfishapp

SOURCES += src/quattroquarti.cpp

QMLSOURCES += qml/quattroquarti.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml

OTHER_FILES += qml/quattroquarti.qml \
    qml/cover/CoverPage.qml \
    qml/pages/MetronomePage.qml \
    qml/pages/SecondPage.qml \
    rpm/quattroquarti.spec \
    rpm/quattroquarti.yaml \
    quattroquarti.desktop

lupdate_only {
    SOURCES += $$QMLSOURCES
}

CODECFORTR = UTF-8
TRANSLATIONS = i18n/it.ts

i18n.files = $$replace(TRANSLATIONS, .ts, .qm)
i18n.path = /usr/share/$$TARGET/i18n

INSTALLS += i18n

pics.files = pics/*.png
pics.path = /usr/share/$$TARGET/pics

INSTALLS += pics

sound.files = sound/*.wav
sound.path = /usr/share/$$TARGET/sound

INSTALLS += sound

VERSION_STRING = '\\"$${VERSION}\\"'
DEFINES += VERSION_STRING=\"$${VERSION_STRING}\"

APPLICATION_NAME = '\\"$${NAME}\\"'
DEFINES += APPLICATION_NAME=\"$${APPLICATION_NAME}\"
