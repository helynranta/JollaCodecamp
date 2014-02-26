
import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    property int resizeVal : 2
    SilicaListView {
        id: listView
        model: bundesligaModel.teamCount
        anchors.fill: parent
        header: PageHeader {
            title: "La Liga Ladder"
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
                        x: laligaModel.get(index).logox/resizeVal
                        y: laligaModel.get(index).logoy/resizeVal
                        width: 1364/resizeVal
                        height: 658/resizeVal
                        source: "../img/laliga_teams_logos.png"
                    }
                }
                Text
                {
                    x: 100
                    text: laligaModel.get(index).position + ". " + laligaModel.get(index).name
                    font.pixelSize: Theme.fontSizeLarge
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                }
                Text
                {
                    x: 100
                    y: 50
                    text:"Won: "+laligaModel.get(index).won + " Drawn: " + laligaModel.get(index).drawn + " Lost: " + laligaModel.get(index).lost
                    font.pixelSize: Theme.fontSizeMedium
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                }
                Text
                {
                    x: 100
                    y: 80
                    text:"Goals Against: "+laligaModel.get(index).goalsAgainst + " GoalsFor: " + laligaModel.get(index).goalsFor
                    font.pixelSize: Theme.fontSizeExtraSmall
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                }
            }
            onClicked: console.log("Clicked " + index)
        }
        VerticalScrollDecorator { flickable: listView }
    }
}

