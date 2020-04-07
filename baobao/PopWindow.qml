import QtQuick 2.12
import QtQuick.Window 2.11
import "dataInf.js" as DateInf

Window {
    signal overDrink()
    function animationStart(){
        rootWin.show()
        rootRect.anchors.bottomMargin = rootWin.height
        showAnimation.start()
    }
    function alreadyDrink(){      
        timerTool.drinkTimePush(DateInf.getLoctateTime())
        console.log("------------------" + timerTool.drinkTime)
        timerTool.timeRefresh() ;
        imageSource = "normalPig.PNG"
        closeAnimation.start()
        timerTool.timerStart()
        drinkPoints+=5
        overDrink()
    }

    id:rootWin
    color: "transparent"
    flags: Qt.Window | Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint
    MouseArea{
        anchors.fill: parent
        onDoubleClicked: {
            rootWin.close()
        }
        onClicked: {
            showAnimation.start()
        }
    }
    NumberAnimation{
        id:showAnimation
        target: rootRect
        properties: "anchors.bottomMargin"
        to:0
        duration: 1500
    }
    NumberAnimation{
        id:closeAnimation
        target: rootRect
        properties: "anchors.bottomMargin"
        to:rootWin.height
        duration: 1500
        onFinished: {
            rootWin.close()
        }
    }
    Rectangle{
        id:shadowRect //窗口第一次出現之前，shadowRect高度值不存在
        anchors.fill: parent
        visible: true
        color: "transparent"
    }
    Rectangle{
        id:rootRect
        anchors.right: shadowRect.right
        anchors.left: shadowRect.left
        anchors.bottom: shadowRect.bottom
        height: shadowRect.height
        anchors.bottomMargin: shadowRect.height
        color: "transparent"
        Rectangle{
            id:topRect
            width: parent.width
            height: parent.height / 10
            color: "transparent"
            z:dialogRect.z + 1
            Rectangle{
                id:topLeftRect
                width: 6
                height: parent.height
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.leftMargin: 20
                color: "#EEA9B8"
                radius: width/2
            }
            Rectangle{
                id:topRightRect
                width: 6
                height: parent.height
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.rightMargin: 20
                color: "#EEA9B8"
                radius: width/2
            }
        }
        Rectangle{
            id:dialogRect
            anchors.top: topRect.bottom
            anchors.bottom: rootRect.bottom
            anchors.right: rootRect.right
            anchors.left: rootRect.left
            color: outputColor()
            radius: 5
            border.width: 2
            border.color: "green"
            Text {
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: parent.height/2
                id: textArea
                text: qsTr("喝水了")
                font.pointSize: 12
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }
        Column{
            anchors.horizontalCenter: dialogRect.horizontalCenter
            anchors.top: dialogRect.top
            anchors.topMargin: dialogRect.height/2 + 10
            anchors.bottom: dialogRect.bottom
            width: parent.width-20
            anchors.bottomMargin: 8
            spacing: 10
            Repeater{
                model:["喝完了","不想喝"]
                Button{
                    border.width: 2
                    radius: 2
                    addColor: "#0FF"
                    height: 20
                    textSpace: false
                    textHorAlignment: Text.AlignHCenter
                    addText: modelData
                    onButtonClicked: {
                        switch(index){
                        case 0:
                            alreadyDrink();
                            drinkTimesOnTime += 1
                            break ;
                        case 1: break;
                        }
                    }
                }
            }
        }
    }
}

