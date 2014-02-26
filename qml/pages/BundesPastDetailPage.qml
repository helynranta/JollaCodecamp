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
                text: bundesligaModel.parseData[theIndex][2] + " vs. "+bundesligaModel.parseData[theIndex][3]
                font.pixelSize: Theme.fontSizeLarge
                color: Theme.primaryColor
            }

            Text
            {
                x: Theme.paddingLarge
                text: bundesligaModel.parseData[theIndex][1]
                font.pixelSize: Theme.fontSizeMedium
                color: Theme.primaryColor
            }

            Text
            {
                x: Theme.paddingLarge
                text: "Score: "+bundesligaModel.parseData[theIndex][4] + " - "+bundesligaModel.parseData[theIndex][5]
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.primaryColor
            }

            Text
            {
                x: Theme.paddingLarge
                text: "Shots: "+bundesligaModel.parseData[theIndex][10] + " - "+bundesligaModel.parseData[theIndex][11]
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.primaryColor
            }

            Text
            {
                x: Theme.paddingLarge
                text: "On target: "+bundesligaModel.parseData[theIndex][12] + " - "+bundesligaModel.parseData[theIndex][13]
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.primaryColor
            }

            Text
            {
                x: Theme.paddingLarge
                text: "Fouls: "+bundesligaModel.parseData[theIndex][14] + " - "+bundesligaModel.parseData[theIndex][15]
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.primaryColor
            }

            Text
            {
                x: Theme.paddingLarge
                text: "Corners: "+bundesligaModel.parseData[theIndex][16] + " - "+bundesligaModel.parseData[theIndex][17]
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.primaryColor
            }

            Text
            {
                x: Theme.paddingLarge
                text: "Yellow cards: "+bundesligaModel.parseData[theIndex][18] + " - "+bundesligaModel.parseData[theIndex][19]
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.primaryColor
            }

            Text
            {
                x: Theme.paddingLarge
                text: "Red cards: "+bundesligaModel.parseData[theIndex][20] + " - "+bundesligaModel.parseData[theIndex][21]
                font.pixelSize: Theme.fontSizeSmall
                color: Theme.primaryColor
            }

        }
    }
}


