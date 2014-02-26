
import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    property int resizeVal : 2
    SilicaListView {
        id: listView
        model: bundesligaModel.teamCount
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
                        x: bundesligaModel.get(index).logox/resizeVal
                        y: bundesligaModel.get(index).logoy/resizeVal
                        width: 1287/resizeVal
                        height: 608/resizeVal
                        source: "../img/bundesliga_teams_logos.png"
                    }
                }
                Text
                {
                    x: 100
                    text: bundesligaModel.get(index).position + ". " + bundesligaModel.get(index).name
                    font.pixelSize: Theme.fontSizeLarge
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                }
                Text
                {
                    x: 100
                    y: 50
                    text:"Won: "+bundesligaModel.get(index).won + " Drawn: " + bundesligaModel.get(index).drawn + " Lost: " + bundesligaModel.get(index).lost
                    font.pixelSize: Theme.fontSizeMedium
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                }
                Text
                {
                    x: 100
                    y: 80
                    text:"Goals Against: "+bundesligaModel.get(index).goalsAgainst + " GoalsFor: " + bundesligaModel.get(index).goalsFor
                    font.pixelSize: Theme.fontSizeExtraSmall
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                }
            }
            onClicked: console.log("Clicked " + index)
        }
        VerticalScrollDecorator { flickable: listView }
    }
}

