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
import QtQuick.XmlListModel 2.0
import "pages"

ApplicationWindow
{
    XmlListModel
    {
        id: wikitable
        source: "http://en.wikipedia.org/w/api.php?format=xml&action=query&generator=templates&titles=2013%E2%80%9314_Premier_League&prop=revisions&rvprop=content"
        query: "/api/query/pages/page[@pageid=39501437]/revisions"

        XmlRole
        {
            name: "teksti"
            query: "rev/string()"
        }

        onStatusChanged:
        {
            if (status === XmlListModel.Ready)
            {
                var txt = get(0).teksti.replace("\n", "");
                var matches = txt.match(/Fb cl team(.*?)bold/g);
                //console.log(matches)
                teamModel.teamCount = 0;
                teamModel.clear();
                for(var i=0; i<matches.length; i++){
                    var d = {}
                    console.log(matches[i])
                    var chunks = matches[i].split('|')
                    for(var n=0; n<chunks.length; n++){
                        if(chunks[n].indexOf('=') > -1){
                            var tmp = chunks[n].split('=', 2)
                            var k = tmp[0].trim()
                            var v = tmp[1].trim()
                            d[k] = v
                        }
                    }
                    if(teamModel.teamImgCord[d["t"]]!= null)
                    {
                        teamModel.append({"name":d["t"],"position":d["p"],
                                            "logox":teamModel.teamImgCord[d["t"]][0],
                                            "logoy":teamModel.teamImgCord[d["t"]][1],
                                             "goalsFor":d["gf"],"goalsAgainst":d["ga"],
                                             "won":d["w"], "lost":d["l"],"drawn":d["d"]
                                       });
                    }
                    teamModel.teamCount += 1;
                }
                console.log(teamModel.teamCount)
            }
        }
    }

    ListModel
    {
        id : teamModel
        property string text: "loading"
        property variant stringArray : []
        property int teamCount : 1
        property var parseData : []
        property var teamImgCord :{
         "Chelsea" : [-780,-198],
         "Arsenal" : [-390,-195],
         "Manchester City" : [-585,-782],
         "Liverpool" : [-975,-197],
         "Tottenham Hotspur" : [-195,-197],
         "Manchester United" : [-780,-392],
         "Everton" : [-1170,-782],
         "Newcastle United" : [-780,-587],
         "Southampton" : [-780,-2],
         "West Ham United" : [-195,-587],
         "Hull City" : [-392,-392],
         "Swansea City" : [1000,1000],
         "Aston Villa" : [-1170,-587],
         "Norwich City" : [1000,1000],
         "Stoke City" : [-972,-782],
         "Crystal Palace" : [-195,-2],
         "West Bromwich Albion" : [-585,-197],
         "Sunderland" : [-195,-782],
         "Cardiff City" : [1000,1000],
         "Fulham" : [-0,-588]
        }


        signal loadCompleted()

        Component.onCompleted:
        {
            text = "does it even work ffs";
            var xhr = new XMLHttpRequest;
            xhr.open("GET", "http://www.football-data.co.uk/mmz4281/1314/E1.csv", true);
            xhr.send();
            xhr.onreadystatechange = function()
            {
                text = "gibestive text";
                if(xhr.readyState == XMLHttpRequest.DONE)
                {
                    text = xhr.responseText;
                    stringArray = text.split("\n");
                    text = "";
                    var arrayLength = stringArray.length;
                    for(var i = 1; i < arrayLength; i++)
                    {
                        var tempSplit = stringArray[i].split(",");
                        parseData.push(tempSplit);
                        //text += tempSplit[2] + " vs " + tempSplit[3] + "\n";
                    }
                }
            }
        }
        ListElement
        {
            name : "e.g. Team"
            position : "-1"
            goalsFor: "-1"
            goalsAgainst : "-1"
            won : "-1"
            lost : "-1"
            drawn : "-1"
            logox: -390
            logoy: -195
            source: "img/barclays_teams_logos.png"
        }
    }

    initialPage: Component { FirstPage { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
}


