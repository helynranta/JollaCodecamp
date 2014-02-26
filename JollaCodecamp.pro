# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = JollaCodecamp

CONFIG += sailfishapp

SOURCES += src/JollaCodecamp.cpp

OTHER_FILES += qml/JollaCodecamp.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/SecondPage.qml \
    rpm/JollaCodecamp.spec \
    rpm/JollaCodecamp.yaml \
    JollaCodecamp.desktop \
    qml/img/barclays_logo.jpg \
    qml/img/barclays_teams_logos.jpg \
    qml/pages/WikipediaSearch.qml \
    qml/pages/MainMenu.qml \
    qml/pages/PremierPastPage.qml \
    qml/pages/ThirdPage.qml \
    qml/pages/PremierPastDetailPage.qml

