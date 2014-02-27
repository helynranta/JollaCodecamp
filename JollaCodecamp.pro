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
    rpm/JollaCodecamp.spec \
    rpm/JollaCodecamp.yaml \
    JollaCodecamp.desktop \
    qml/img/barclays_logo.jpg \
    qml/img/barclays_teams_logos.jpg \
    qml/pages/WikipediaSearch.qml \
    qml/pages/MainMenu.qml \
    qml/pages/PremierPastPage.qml \
    qml/pages/PremierPastDetailPage.qml \
    qml/pages/BundesLadderPage.qml \
    qml/pages/PremierLadderPage.qml \
    qml/pages/PremierUpcomingPage.qml \
    qml/pages/LaligaLadderPage.qml \
    qml/pages/BundesPastDetailPage.qml \
    qml/pages/BundesPastPage.qml \
    qml/pages/LaligaPastPage.qml \
    qml/pages/LaligaPastDetailPage.qml \
    qml/pages/MainMenu2.qml \
    qml/pages/PremierMenuPage.qml \
    qml/pages/BundesMenuPage.qml \
    qml/pages/LaligaMenuPage.qml \
    qml/pages/BundesUpcomingPage.qml \
    qml/pages/LaligaUpcomingPage.qml

