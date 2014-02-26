

import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    property int resizeVal : 2
    SilicaListView {
        id: listView
        model: teamModel.teamCount
        anchors.fill: parent
        header: PageHeader {
            title: "Nested Page"
        }

        delegate: BackgroundItem {
            id: delegate
            height: 130
            Label {

                Rectangle{
                    color :"transparent"
                    clip: true
                    width: 195/resizeVal
                    height: 195/resizeVal
                    Image {
                        x: teamModel.get(index).logox/resizeVal
                        y: teamModel.get(index).logoy/resizeVal
                        width: 1365/resizeVal
                        height: 1024/resizeVal
                        source: "../img/barclays_teams_logos.png"
                    }
                }
                Text
                {
                    x: 100
                    text: teamModel.get(index).position + ". " + teamModel.get(index).name
                    font.pixelSize: Theme.fontSizeLarge
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                }
                Text
                {
                    x: 100
                    y: 50
                    text:"Won: "+teamModel.get(index).won + " Drawn: " + teamModel.get(index).drawn + " Lost: " + teamModel.get(index).lost
                    font.pixelSize: Theme.fontSizeMedium
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                }
                Text
                {
                    x: 100
                    y: 80
                    text:"Goals Against: "+teamModel.get(index).goalsAgainst + " GoalsFor: " + teamModel.get(index).goalsFor
                    font.pixelSize: Theme.fontSizeExtraSmall
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                }
            }
            onClicked: console.log("Clicked " + index)
        }
        VerticalScrollDecorator { flickable: listView }
    }
}





