

import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    property int resizeVal : 2
    SilicaListView {
        id: listView
        model: 20
        anchors.fill: parent
        header: PageHeader {
            title: "Bundesliga Upcoming"
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
                            x: bundesligaModel.teamImgCord[bundesUpcoming.next20games[index][1]][0]/resizeVal
                            y: bundesligaModel.teamImgCord[bundesUpcoming.next20games[index][1]][1]/resizeVal
                            width: 1287/resizeVal
                            height: 608/resizeVal
                            source: "../img/bundesliga_teams_logos.png"
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
                            x: bundesligaModel.teamImgCord[bundesUpcoming.next20games[index][2]][0]/resizeVal
                            y: bundesligaModel.teamImgCord[bundesUpcoming.next20games[index][2]][1]/resizeVal
                            width: 1287/resizeVal
                            height: 608/resizeVal
                            source: "../img/bundesliga_teams_logos.png"
                        }
                    }
                }
                Column{
                    Text
                    {
                        text: bundesUpcoming.next20games[index][1]
                        font.pixelSize: Theme.fontSizeSmall
                        color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                    }
                    Text
                    {
                        y: 30

                        text: bundesUpcoming.next20games[index][2]
                        font.pixelSize: Theme.fontSizeSmall
                        color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                    }
                    Text
                    {
                        y: 60
                        text: bundesUpcoming.next20games[index][0]
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





