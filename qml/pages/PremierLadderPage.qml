

import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    property int resizeVal : 2
    SilicaListView {
        id: listView
        model: premierModel.teamCount
        anchors.fill: parent
        header: PageHeader {
<<<<<<< HEAD
            title: "Premier League"
=======
            title: "Premier League Ladder"
>>>>>>> d1b5ece442a5774f0b26d77a3f22fbd2eb71cef6
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
                        x: premierModel.get(index).logox/resizeVal
                        y: premierModel.get(index).logoy/resizeVal
                        width: 1365/resizeVal
                        height: 1024/resizeVal
                        source: "../img/barclays_teams_logos.png"
                    }
                }
                Text
                {
                    x: 100
                    text: premierModel.get(index).position + ". " + premierModel.get(index).name
                    font.pixelSize: Theme.fontSizeLarge
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                }
                Text
                {
                    x: 100
                    y: 50
                    text:"Won: "+premierModel.get(index).won + " Drawn: " + premierModel.get(index).drawn + " Lost: " + premierModel.get(index).lost
                    font.pixelSize: Theme.fontSizeMedium
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                }
                Text
                {
                    x: 100
                    y: 80
                    text:"Goals Against: "+premierModel.get(index).goalsAgainst + " GoalsFor: " + premierModel.get(index).goalsFor
                    font.pixelSize: Theme.fontSizeExtraSmall
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                }
            }
            onClicked: console.log("Clicked " + index)
        }
        VerticalScrollDecorator { flickable: listView }
    }
}





