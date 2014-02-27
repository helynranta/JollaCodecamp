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
    /**************************
     xml parsing for barclays
    ***************************/
    XmlListModel
    {
        id: premierXML
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
                premierModel.teamCount = 0;
                premierModel.clear();
                for(var i=0; i<matches.length; i++){
                    var d = {}
                    //console.log(matches[i])
                    var chunks = matches[i].split('|')
                    for(var n=0; n<chunks.length; n++){
                        if(chunks[n].indexOf('=') > -1)
                        {
                            var tmp = chunks[n].split('=', 2)
                            var k = tmp[0].trim()
                            var v = tmp[1].trim()
                            d[k] = v
                        }
                    }
                    if(premierModel.teamImgCord[d["t"]]!= null)
                    {
                        premierModel.append({"name":d["t"],"position":d["p"],
                                            "logox":premierModel.teamImgCord[d["t"]][0],
                                            "logoy":premierModel.teamImgCord[d["t"]][1],
                                             "goalsFor":d["gf"],"goalsAgainst":d["ga"],
                                             "won":d["w"], "lost":d["l"],"drawn":d["d"]
                                       });
                    }
                    premierModel.teamCount += 1;
                }
                //console.log(premierModel.teamCount)
            }
        }
    }
    /**************************
       Barclays team list
    ***************************/
    ListModel
    {
        id : premierModel
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
         "Norwich City" : [-390,-195],
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
                    for(var i = 1; i < arrayLength-1; i++) //last line is empty
                    {
                        var tempSplit = stringArray[i].split(",");
                        parseData.unshift(tempSplit); //insert as first
                    }
                }
            }
        }
    }
    /**************************
    xml parsing for bundelsliga
    fetches data from wikipedia api
    ***************************/
    XmlListModel
    {
            id: bundesligaXML
            source: "http://en.wikipedia.org/w/api.php?format=xml&action=query&titles=Template:Current_Fu%C3%9Fball-Bundesliga_table&prop=revisions&rvprop=content"
            query: "/api/query/pages/page/revisions"

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
                    var matches = txt.match(/Fb cl team(.*?)\}\}/g);

                    //console.log(matches)
                    bundesligaModel.teamCount = 0;
                    bundesligaModel.clear();
                    for(var i=0; i<matches.length; i++){
                        var d = {}
                        //console.log(matches[i])
                        var chunks = matches[i].replace("}}", "").split('|') //dat workaround..

                        for(var n=0; n<chunks.length; n++){
                            if(chunks[n].indexOf('=') > -1){
                                var tmp = chunks[n].split('=', 2)
                                var k = tmp[0].trim()
                                var v = tmp[1].trim()
                                d[k] = v
                            }
                        }
                        if(bundesligaModel.teamImgCord[d["t"]]!= null)
                        {
                            bundesligaModel.append({"name":d["t"],"position":d["p"],
                                                "logox":bundesligaModel.teamImgCord[d["t"]][0],
                                                "logoy":bundesligaModel.teamImgCord[d["t"]][1],
                                                 "goalsFor":d["gf"],"goalsAgainst":d["ga"],
                                                 "won":d["w"], "lost":d["l"],"drawn":d["d"]
                                           });
                        }
                        bundesligaModel.teamCount += 1;
                    }
                }
            }
        }
    /*************************
      Bundesliga team list
    **************************/
    ListModel
    {
            id : bundesligaModel
            property string text: "loading"
            property variant stringArray : []
            property int teamCount : 1
            property var parseData : []
            property var teamImgCord :{
                "Bayern Munich" : [-0,-0],
                "Leverkusen" : [-210,-210],
                "Borussia Dortmund" : [-0,-196],
                "Schalke 04" : [-0,-410],
                "VfL Wolfsburg" : [-1108,-410],
                "Mönchengladbach" : [-643,-187],
                "Hertha BSC" : [-829,-202],
                "Augsburg" : [-1129,-2],
                "Mainz" : [-888,-410],
                "Hoffenheim" : [-447,-214],
                "Hannover 96" : [-882,-0],
                "Nürnberg" : [-655,-410],
                "Eintracht Frankfurt" : [-655,-2],
                "Werder Bremen" : [-205,-5],
                "Stuttgart" : [-424,-410],
                "Hamburg" : [-1068,-212],
                "Freiburg" : [-222,-412],
                "Braunschweig" : [-829,-202]
            }
            signal loadCompleted()

            Component.onCompleted:
            {
                text = "does it even work ffs";
                var xhr = new XMLHttpRequest;
                xhr.open("GET", "http://www.football-data.co.uk/mmz4281/1314/D1.csv", true);
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
                        for(var i = 1; i < arrayLength-1; i++) //last line is empty
                        {
                            var tempSplit = stringArray[i].split(",");
                            parseData.unshift(tempSplit); //insert as first

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


    /**************************
    xml parsing for La Liga
    fetches data from wikipedia api
    ***************************/
    XmlListModel
    {
            id: laligaXML
            source: "http://en.wikipedia.org/w/api.php?format=xml&action=query&titles=2013%E2%80%9314_La_Liga&prop=revisions&rvprop=content"
            query: "/api/query/pages/page/revisions"

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
                    var matches = txt.match(/Fb cl team(.*?)\}\}/g);
                    //console.log(matches)
                    laligaModel.teamCount = 0;
                    laligaModel.clear();
                    for(var i=0; i<matches.length; i++){
                        var d = {}
                        //console.log(matches[i])
                        var chunks = matches[i].split('|')
                        for(var n=0; n<chunks.length; n++){
                            if(chunks[n].indexOf('=') > -1){
                                var tmp = chunks[n].split('=', 2)
                                var k = tmp[0].trim()
                                var v = tmp[1].trim()
                                d[k] = v
                            }
                        }
                        if(laligaModel.teamImgCord[d["t"]]!= null)
                        {
                            laligaModel.append({"name":d["t"],"position":d["p"],
                                                "logox":laligaModel.teamImgCord[d["t"]][0],
                                                "logoy":laligaModel.teamImgCord[d["t"]][1],
                                                 "goalsFor":d["gf"],"goalsAgainst":d["ga"],
                                                 "won":d["w"], "lost":d["l"],"drawn":d["d"]
                                           });
                        }
                        laligaModel.teamCount += 1;
                    }
                }
            }
        }
    /*************************
      La Liga team list
    **************************/
    ListModel
    {
            id : laligaModel
            property string text: "loading"
            property variant stringArray : []
            property int teamCount : 1
            property var parseData : []
            property var teamImgCord :{
                "Real Madrid" : [-0,-220],
                "Barcelona" : [-0,-0],
                "Atlético Madrid" : [-0,-448],
                "Athletic Bilbao" : [-851,-454],
                "Villarreal" : [1000,1000],
                "Real Sociedad" : [-433,-4],
                "Valencia" : [-219,-217],
                "Sevilla" : [-642,-0],
                "Levante" : [-438,-450],
                "Espanyol" : [-855,-0],
                "Celta de Vigo" : [-1227,-0],
                "Osasuna" : [-1048,-216],
                "Granada" : [-1231,-219],
                "Elche" : [1000,1000],
                "Almería" : [1000,1000],
                "Getafe" : [-646,-451],
                "Malaga" : [-210,-0],
                "Valladolid" : [-645,-214],
                "Rayo Vallecano" : [-198,-448],
                "Betis" : [-423,-214]
            }

            signal loadCompleted()

            Component.onCompleted:
            {
                text = "does it even work ffs";
                var xhr = new XMLHttpRequest;
                xhr.open("GET", "http://www.football-data.co.uk/mmz4281/1314/SP1.csv", true);
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
                        for(var i = 1; i < arrayLength-1; i++) //last line is empty
                        {
                            var tempSplit = stringArray[i].split(",");
                            parseData.unshift(tempSplit); //insert as first
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




    /**************************
     bundesliga upcoming games
    ***************************/
    ListModel
    {
        id : bundesUpcoming
        property var bundesArray : []
        property string covertext : "Cover"
        property var coverarray : []
        property var next20games : []

        Component.onCompleted:
        {
            var xhr = new XMLHttpRequest;
            xhr.open("GET", "http://koti.mbnet.fi/lasshi/opendata/bundesliga_schedule.csv", true);
            xhr.send();
            xhr.onreadystatechange = function()
            {
                if(xhr.readyState == XMLHttpRequest.DONE)
                {
                    var lineArray = xhr.responseText.split("\n");
                    var lineLenght = lineArray.length;
                    for(var i = 0; i < lineLenght; i++)
                    {
                        var gameArr = lineArray[i].split(",");
                        bundesUpcoming.bundesArray.push(gameArr);
                    }
                    var date = new Date();
                    var month = date.getMonth()+1;
                    var day = date.getDate();
                    var year = date.getFullYear();

                    var found = false
                    var listLen = bundesUpcoming.bundesArray.length
                    for(var i = 0; i < listLen; i++)
                    {
                        var gameDate = bundesUpcoming.bundesArray[i][0].split("/")
                        console.log(gameDate[0]+"/"+gameDate[1]+"/"+gameDate[2]);
                        if(((gameDate[0]>day && gameDate[1]==month)|| gameDate[1] > month))
                        {
                            bundesUpcoming.coverarray.push(gameDate[0]+"/"+gameDate[1]+"/2014");
                            bundesUpcoming.coverarray.push(bundesUpcoming.bundesArray[i][1]);
                            bundesUpcoming.coverarray.push(bundesUpcoming.bundesArray[i][2]);
                            for(var a=0; a < 20;a++)
                                next20games.push(bundesUpcoming[i+a])
                            found = true;
                        }
                        if(found)
                            break;
                    }
                    coverlabel.imgSizex = 1287;
                    coverlabel.imgSizey = 608;
                    coverlabel.imgSource = "img/bundesliga_teams_logos.png";
                    coverlabel.covertext = bundesUpcoming.coverarray[0];
                    coverlabel.logo1x = bundesligaModel.teamImgCord[bundesUpcoming.coverarray[1]][0]/coverlabel.resizeVal
                    coverlabel.logo1y = bundesligaModel.teamImgCord[bundesUpcoming.coverarray[1]][1]/coverlabel.resizeVal
                    coverlabel.logo2x = bundesligaModel.teamImgCord[bundesUpcoming.coverarray[2]][0]/coverlabel.resizeVal
                    coverlabel.logo2y = bundesligaModel.teamImgCord[bundesUpcoming.coverarray[2]][1]/coverlabel.resizeVal
                }
            }
        }
    }
    /**************************
     premier upcoming games
    ***************************/
    ListModel
    {
        id : barclaysUpcoming
        property var premierArray : []
        property var next20games : []
        property var coverarray : []

        signal onCompleted();

        Component.onCompleted:
        {
            var xhr = new XMLHttpRequest;
            xhr.open("GET", "http://koti.mbnet.fi/lasshi/opendata/barclays_schedule.csv", true);
            xhr.send();
            xhr.onreadystatechange = function()
            {
                if(xhr.readyState == XMLHttpRequest.DONE)
                {
                    var lineArray = xhr.responseText.split("\n");
                    var lineLenght = lineArray.length;
                    for(var i = 0; i < lineLenght; i++)
                    {
                        var gameArr = lineArray[i].split(",");
                        barclaysUpcoming.premierArray.push(gameArr);
                    }
                    var date = new Date();
                    var month = date.getMonth()+1;
                    var day = date.getDate();
                    var year = date.getFullYear();

                    var found = false
                    var listLen = barclaysUpcoming.premierArray.length
                    for(var i = 0; i < listLen; i++)
                    {
                        var gameDate = barclaysUpcoming.premierArray[i][0].split("/")

                        if(((gameDate[0]>day && gameDate[1]==month)|| gameDate[1] > month) && gameDate[2]==year)
                        {
                            barclaysUpcoming.coverarray.push(gameDate[0]+"/"+gameDate[1]+"/2014");//purkka
                            barclaysUpcoming.coverarray.push(barclaysUpcoming.premierArray[i][1]);
                            barclaysUpcoming.coverarray.push(barclaysUpcoming.premierArray[i][2]);
                            for(var a=0; a < 20;a++){
                                next20games.push(barclaysUpcoming.premierArray[i+a])
                            }
                            found = true;
                        }
                        if(found)
                            break;
                    }
                }
            }
        }
    }

    initialPage: Component { MainMenu2 { } }

    /*
      COVER CODE BLES
      */
    cover:
        CoverBackground {
            Label
            {
                id : coverlabel
                height: 400
                width: 200
                property string covertext : "Swipe right to Bundes\nand left for Premier upcoming"
                property string logo1x : ""
                property string logo1y : ""
                property string logo2x : ""
                property string logo2y : ""
                property string imgSource : "img/barclays_teams_logos.png"
                property double resizeVal : 2.5
                property double imgSizex : 100
                property double imgSizey : 100

                Text
                {
                    text: "Upcoming games:\n\n\n\n\n\n\n"
                    anchors.centerIn: parent
                    color: Theme.primaryColor
                    font.pixelSize: Theme.fontSizeExtraSmall
                }
                Text
                {
                    text:coverlabel.covertext +  "\n\n\n"
                    anchors.centerIn: parent
                    color: Theme.primaryColor
                    font.pixelSize: Theme.fontSizeSmall
                }

                Rectangle{
                    id : logo1
                    color :"transparent"
                    clip: true
                    x: 20
                    SequentialAnimation on y {
                                id: coverxnaim1
                                // Animations on properties start running by default
                                running: true
                                loops: Animation.Infinite // The animation is set to loop indefinitely
                                NumberAnimation { from: 300; to: 100; duration: 1000; easing.type: Easing.InOutQuad }
                                NumberAnimation { from: 100; to: 300; duration: 0; easing.type: Easing.InOutQuad }
                    }
                    width: 195/coverlabel.resizeVal
                    height: 195/coverlabel.resizeVal
                    Image {
                        id: coverteam1logo
                        x: coverlabel.logo1x
                        y: coverlabel.logo1y
                        width: coverlabel.imgSizex/coverlabel.resizeVal
                        height: coverlabel.imgSizey/coverlabel.resizeVal
                        source: coverlabel.imgSource
                        SequentialAnimation on opacity {
                                    id: coveropacitynaim1
                                    // Animations on properties start running by default
                                    running: true
                                    loops: Animation.Infinite // The animation is set to loop indefinitely
                                    NumberAnimation { from: 0; to: 0; duration: 100; easing.type: Easing.InOutQuad }
                                    NumberAnimation { from: 0; to: 1; duration: 600; easing.type: Easing.InOutQuad }
                                    NumberAnimation { from: 1; to: 0; duration: 300; easing.type: Easing.InOutQuad }
                        }
                    }
                }
                Rectangle
                {
                     color :"transparent"
                     clip: true
                     anchors.verticalCenter: parent
                     x: 140
                     y: logo1.y
                     width: 195/coverlabel.resizeVal
                     height: 195/coverlabel.resizeVal
                     Image {
                         id: coverteam2logo
                         x: coverlabel.logo2x
                         y: coverlabel.logo2y
                         opacity: coverteam1logo.opacity
                         width: coverlabel.imgSizex/coverlabel.resizeVal
                         height: coverlabel.imgSizey/coverlabel.resizeVal
                         source: coverlabel.imgSource
                     }
                 }

            }

            CoverActionList {
                id: coverAction

                CoverAction
                {
                    iconSource: "img/bundesliga_logo.png"

                    onTriggered:
                    {
                        coverlabel.imgSizex = 1287;
                        coverlabel.imgSizey = 608;
                        coverlabel.imgSource = "img/bundesliga_teams_logos.png";
                        coverlabel.covertext = bundesUpcoming.coverarray[0];
                        coverlabel.logo1x = bundesligaModel.teamImgCord[bundesUpcoming.coverarray[1]][0]/coverlabel.resizeVal
                        coverlabel.logo1y = bundesligaModel.teamImgCord[bundesUpcoming.coverarray[1]][1]/coverlabel.resizeVal
                        coverlabel.logo2x = bundesligaModel.teamImgCord[bundesUpcoming.coverarray[2]][0]/coverlabel.resizeVal
                        coverlabel.logo2y = bundesligaModel.teamImgCord[bundesUpcoming.coverarray[2]][1]/coverlabel.resizeVal
                    }
                }

                CoverAction
                {
                    iconSource: "img/barclays_logo.png"

                    onTriggered:
                    {
                        coverlabel.imgSizex = 1365;
                        coverlabel.imgSizey =  1024;
                        coverlabel.imgSource = "img/barclays_teams_logos.png";
                        coverlabel.covertext = barclaysUpcoming.coverarray[0];
                        coverlabel.logo1x = premierModel.teamImgCord[barclaysUpcoming.coverarray[1]][0]/coverlabel.resizeVal
                        coverlabel.logo1y = premierModel.teamImgCord[barclaysUpcoming.coverarray[1]][1]/coverlabel.resizeVal
                        coverlabel.logo2x = premierModel.teamImgCord[barclaysUpcoming.coverarray[2]][0]/coverlabel.resizeVal
                        coverlabel.logo2y = premierModel.teamImgCord[barclaysUpcoming.coverarray[2]][1]/coverlabel.resizeVal
                    }
                }
            }
        }
}
