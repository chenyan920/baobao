import QtQuick 2.12
import QtGraphicalEffects 1.0

Rectangle {
    function setFromGame(index){
        repeater.itemAt(index).leftColor = "red"
        var temp = Number(repeater.itemAt(index).rightText)
        temp += 1
        repeater.itemAt(index).rightText = String(temp)
    }
    property int gameStatus: 100

    property alias statusWidth: statusPrograss.width
    id:rootRect
    width: parseInt(parent.width*1/2)
    height:90
    color: "transparent"
    onGameStatusChanged: {
        if(gameStatus === 0){
            gameOver()
        }
    }
    Rectangle{
        color: "#9AFF9A"
        radius: height/2
        height: parent.height
        width: parent.width
        anchors.left: parent.left
        border.width: 2
        border.color: "#90EE90"
        Rectangle{
            id:imageBaseRect
            height: parent.height
            width: height
            anchors.left: parent.left
            color: "transparent"
            Rectangle{
                id:imageRect
                anchors.fill: parent
                anchors.margins: 3
                radius: height/2
                color: "#C0FF3E"
                Image {
                    id: clockImg
                    visible: false
                    anchors.fill: parent
                    anchors.margins: 2
                    clip: true
                    smooth: true
                    source: "bao.jpeg"
                    sourceSize: Qt.size(parent.size, parent.size)
                    antialiasing: true
                }
                OpacityMask {
                    id: maskImage
                    anchors.fill: clockImg
                    source: clockImg
                    maskSource:imageRect
                    visible: true
                    antialiasing: true
                }
            }
        }
        Rectangle{
            id:statusBaseRect
            anchors.left: imageBaseRect.right
            anchors.right: parent.right
            anchors.rightMargin: parent.height/4
            height: parent.height/3
            color:"transparent"
            Rectangle{
                id:statusRect
                anchors.fill: parent
                anchors.margins: 3
                color: "transparent"//"#EE6363"
                border.width: 1
                border.color: "#EE2C2C"
                radius: height/2
                clip: true
                opacity: 0.9
                Rectangle{
                    id:statusPrograss
                    y:1
                    x:1
                    width:(parent.width-2)*(gameStatus/100)
                    height: parent.height-2
                    anchors.left: parent.left
                    color: "#EE2C2C"
                    radius: height/2
                }
            }
        }
        Grid{
            anchors.left: imageBaseRect.right
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.bottom: parent.bottom
            anchors.top: statusBaseRect.bottom
            columns: 2
            rows: 2
            Repeater{
                id:repeater
                model: ["赶跑臭猪:","漏网臭猪:","挨打香猪:","看到香猪:"]
                InfoRect{
                    id:infoBar
                    height: parent.height/2
                    width: parent.width/2
                    leftText: modelData
                }
            }
        }
    }
}
