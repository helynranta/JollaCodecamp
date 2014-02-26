import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page
    property int theIndex: -1 //some index from pastpage

    // To enable PullDownMenu, place our content in a SilicaFlickable
    SilicaFlickable {
        anchors.fill: parent


        // Tell SilicaFlickable the height of its content.
        contentHeight: column.height

        // Place our content in a Column.  The PageHeader is always placed at the top
        // of the page, followed by our content.
        Column {
            id: column

            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: "Match details"
            }

            Text
            {
                x: Theme.paddingLarge
                text: teamModel.parseData[theIndex][2] + " vs. "+teamModel.parseData[theIndex][3]
                font.pixelSize: Theme.fontSizeLarge
                color: Theme.primaryColor
            }

            Text
            {
                x: Theme.paddingLarge
                text: teamModel.parseData[theIndex][1]
                font.pixelSize: Theme.fontSizeMedium
                color: Theme.primaryColor
            }

            Text
            {
                x: Theme.paddingLarge
                text: "Score: "+teamModel.parseData[theIndex][4] + " - "+teamModel.parseData[theIndex][5]
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.primaryColor
            }


            Text
            {
                x: Theme.paddingLarge
                text: "Referee: "+teamModel.parseData[theIndex][10]
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.primaryColor
            }
        }
    }
}


