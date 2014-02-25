
import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    property int resizeVal : 2
    SilicaListView {
        id: listView
        model: teamModelb.teamCount
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
                        x: teamModelb.get(index).logox/resizeVal
                        y: teamModelb.get(index).logoy/resizeVal
                        width: 1365/resizeVal
                        height: 1024/resizeVal
                        source: "../img/barclays_teams_logos.png"
                    }
                }
                Text
                {
                    x: 100
                    text: teamModelb.get(index).position + ". " + teamModelb.get(index).name
                    font.pixelSize: Theme.fontSizeLarge
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                }
                Text
                {
                    x: 100
                    y: 50
                    text:"Won: "+teamModelb.get(index).won + " Drawn: " + teamModelb.get(index).drawn + " Lost: " + teamModelb.get(index).lost
                    font.pixelSize: Theme.fontSizeMedium
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                }
                Text
                {
                    x: 100
                    y: 80
                    text:"Goals Against: "+teamModelb.get(index).goalsAgainst + " GoalsFor: " + teamModelb.get(index).goalsFor
                    font.pixelSize: Theme.fontSizeExtraSmall
                    color: delegate.highlighted ? Theme.highlightColor : Theme.primaryColor
                }
            }
            onClicked: console.log("Clicked " + index)
        }
        VerticalScrollDecorator { flickable: listView }
    }
}

