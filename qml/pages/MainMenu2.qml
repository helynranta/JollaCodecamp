/*
  Copyright (C) 2013 Jolla Ltd.
  Contact: Thomas Perl <thomas.perl@jollamobile.com>
  All rights reserved.

  You may use this file under the terms of BSD license as follows:

  Redistribution and use in source and binary forms, with or without
  modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Jolla Ltd nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    SilicaListView {
        id: mainMenuView
        height: 500
        width: parent.width
        header: PageHeader {
            title: "Fütböll Gibestive"
        }
        model: ListModel {
            ListElement {
                name: "Premier League"
                page:"PremierLadderPage"
                imgSource:"../img/barclays_logo.png"
            }
            ListElement {
                name: "Bundesliga"
                page:"BundesLadderPage"
                imgSource:"../img/bundesliga_logo.png"
            }
            ListElement {
                name: "La Liga"
                page:"LaligaLadderPage"
                imgSource:"../img/laliga_logo.png"
            }
       }
       delegate: BackgroundItem {
           width: ListView.view.width
           //height: Theme.itemSizeSmall
           Row{
               Column
               {
                   Rectangle{
                       color :"transparent"
                       clip: true
                       x: 0
                       y: 0
                       width: 195/2
                       height: 195/2
                       Image {
                           width: 150/2
                           height: 150/2
                           source: imgSource
                       }
                   }
               }
               x: Theme.paddingLarge
               Column {
                   Text
                   {
                       text : name
                       font.pixelSize: Theme.fontSizeMedium
                       color: Theme.primaryColor
                   }
                   Text
                   {
                       text : "Ladder"
                       font.pixelSize: Theme.fontSizeSmall
                       color: Theme.primaryColor
                   }
                }
            }
           onClicked: pageStack.push(Qt.resolvedUrl(page+".qml"))
       }
       VerticalScrollDecorator { flickable: listView }
    }

    Label{
        x: Theme.paddingLarge
        y: 500
        color: Theme.secondaryColor
        text: "Select a league from the menu for"
    }
    Label{
        x: Theme.paddingLarge
        y: 540
        color: Theme.secondaryColor
        text: "ladder and upcoming and past games"
    }
    Label{
        x: Theme.paddingLarge
        y: 600
        color: Theme.secondaryColor
        text: "Laliga BBVA Upcoming:"
    }
    Label{
        id: laligaUPlabel
        x: Theme.paddingLarge
        y: 640
        color: Theme.primaryColor
        text: laligaUpcoming.menutxt
        SequentialAnimation on x {
                    id: menutextlaliga
                    // Animations on properties start running by default
                    running: true
                    loops: Animation.Infinite // The animation is set to loop indefinitely
                    NumberAnimation { from: 400; to: -10000; duration: 70000;}
                    NumberAnimation { from: -10000; to: 400; duration: 0; }
        }
    }
    Label{
        x: Theme.paddingLarge
        y: 680
        color: Theme.secondaryColor
        text: "Bundesliga Upcoming:"
    }
    Label{
        id: bundesUPlabel
        x: Theme.paddingLarge
        y: 720
        color: Theme.primaryColor
        text: bundesUpcoming.menutxt
        SequentialAnimation on x {
                    id: menutextbundes
                    // Animations on properties start running by default
                    running: true
                    loops: Animation.Infinite // The animation is set to loop indefinitely
                    NumberAnimation { from: 400; to: -10000; duration: 70000;}
                    NumberAnimation { from: -10000; to: 400; duration: 0; }
        }
    }
    Label{
        x: Theme.paddingLarge
        y: 760
        color: Theme.secondaryColor
        text: "Premier Upcoming:"
    }
    Label{
        id: premierUPlabel
        x: Theme.paddingLarge
        y: 800
        color: Theme.primaryColor
        text: barclaysUpcoming.menutxt
        SequentialAnimation on x {
                    id: menutextpremier
                    // Animations on properties start running by default
                    running: true
                    loops: Animation.Infinite // The animation is set to loop indefinitely
                    NumberAnimation { from: 400; to: -10000; duration: 70000;}
                    NumberAnimation { from: -10000; to: 400; duration: 0; }
        }
    }
}
