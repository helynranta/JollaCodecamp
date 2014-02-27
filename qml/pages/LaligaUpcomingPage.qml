

import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    property int resizeVal : 2
    SilicaListView {
        id: laligaupcomingview
        model: 20
        anchors.fill: parent
        header: PageHeader {
            title: "LaLiga BBVA Upcoming"
        }

        delegate: BackgroundItem {
            id: delegate
            height: 130
            Row{
                Column{
                    Rectangle{
                        color :"transparent"
                        clip: true
                        width: 195/resizeVal
                        height: 195/resizeVal
                        Image {
                            x: laligaModel.teamImgCord[laligaUpcoming.next20games[index][1]][0]/resizeVal
                            y: laligaModel.teamImgCord[laligaUpcoming.next20games[index][1]][1]/resizeVal
                            width: 1364/resizeVal
                            height: 658/resizeVal
                            source: "../img/laliga_teams_logos.png"
                        }
                    }
                }
                Column{
                    //anchor:
                    Rectangle{
                        color :"transparent"
                        clip: true
                        width: 195/resizeVal
                        height: 195/resizeVal
                        Image {
                            x: laligaModel.teamImgCord[laligaUpcoming.next20games[index][2]][0]/resizeVal
                            y: laligaModel.teamImgCord[laligaUpcoming.next20games[index][2]][1]/resizeVal
                            width: 1364/resizeVal
                            height: 658/resizeVal
                            source: "../img/laliga_teams_logos.png"
                        }
                    }
                }
                Column{
                    Text
                    {
                        text: laligaUpcoming.next20games[index][1]
                        font.pixelSize: Theme.fontSizeSmall
                        color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                    }
                    Text
                    {
                        y: 30

                        text: laligaUpcoming.next20games[index][2]
                        font.pixelSize: Theme.fontSizeSmall
                        color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                    }
                    Text
                    {
                        y: 60
                        text: laligaUpcoming.next20games[index][0]
                        font.pixelSize: Theme.fontSizeSmall
                        color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                    }
                }
            }
            onClicked: console.log("Clicked " + index)
        }
        VerticalScrollDecorator { flickable: listView }
    }
}






