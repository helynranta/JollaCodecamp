

import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    property int resizeVal : 2
    SilicaListView {
        id: listView
        model: 20
        anchors.fill: parent
        header: PageHeader {
            title: "Premier League Upcoming"
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
                            x: premierModel.teamImgCord[barclaysUpcoming.next20games[index][1]][0]/resizeVal
                            y: premierModel.teamImgCord[barclaysUpcoming.next20games[index][1]][1]/resizeVal
                            width: 1365/resizeVal
                            height: 1024/resizeVal
                            source: "../img/barclays_teams_logos.png"
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
                            x: premierModel.teamImgCord[barclaysUpcoming.next20games[index][2]][0]/resizeVal
                            y: premierModel.teamImgCord[barclaysUpcoming.next20games[index][2]][1]/resizeVal
                            width: 1365/resizeVal
                            height: 1024/resizeVal
                            source: "../img/barclays_teams_logos.png"
                        }
                    }
                }
                Column{
                    Text
                    {
                        text: barclaysUpcoming.next20games[index][1]
                        font.pixelSize: Theme.fontSizeSmall
                        color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                    }
                    Text
                    {
                        y: 30

                        text: barclaysUpcoming.next20games[index][2]
                        font.pixelSize: Theme.fontSizeSmall
                        color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                    }
                    Text
                    {
                        y: 60
                        text: barclaysUpcoming.next20games[index][0]
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





