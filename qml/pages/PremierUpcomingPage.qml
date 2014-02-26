

import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    property int resizeVal : 2
    SilicaListView {
        id: listView
        model: 5
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
                            x: barclaysUpcoming.get(index).logox_a/resizeVal
                            y: barclaysUpcoming.get(index).logoy_a/resizeVal
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
                            x: barclaysUpcoming.get(index).logox_b/resizeVal
                            y: barclaysUpcoming.get(index).logoy_b/resizeVal
                            width: 1365/resizeVal
                            height: 1024/resizeVal
                            source: "../img/barclays_teams_logos.png"
                        }
                    }
                }
                Column{
                    Text
                    {
                        text: barclaysUpcoming.get(index).name_a
                        font.pixelSize: Theme.fontSizeSmall
                        color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                    }
                    Text
                    {
                        y: 30

                        text: barclaysUpcoming.get(index).name_b
                        font.pixelSize: Theme.fontSizeSmall
                        color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                    }
                    Text
                    {
                        y: 60
                        text: barclaysUpcoming.get(index).date
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





