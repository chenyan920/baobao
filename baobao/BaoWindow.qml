import QtQuick 2.12
import QtQuick.Window 2.11
import QtGraphicalEffects 1.0
import "dataInf.js" as DateInf

Window {
    property bool drawStatus: false

    id:rootWin
    x:(Screen.width - width)/2
    y:(Screen.height - height)/2
    height: drawStatus?400:150
    width: 400
    title:"宝宝的页面"
    visible: true
    Rectangle{
        anchors.fill: parent
        id:rootRect
        gradient:Gradient {
            orientation: Gradient.Horizontal
            GradientStop {position: 0.0; color: "#B0E0E6" }
            GradientStop { position: 0.33; color: "#AEEEEE" }
            GradientStop { position: 1.0; color: "white" }
        }
        Rectangle{
            x:0;y:5
            height: 25;width: parent.width
            color: "transparent"
            Text{
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.fill: parent
                text: "今天是猪猪和宝宝在一起的第 "+DateInf.calculateDayToDay(2017,12,30)+" 天"
            }
        }
        Rectangle{
            id:imgRect
            x:25;y:33
            height: 100;
            width: 100
            radius: 50
            border.width:2
            border.color: "black"
            Image {
                id: img
                visible: false
                anchors.fill: parent
                anchors.margins: 2
                clip: true
                smooth: true
                source: "bao.PNG"
                sourceSize: Qt.size(parent.size, parent.size)
                antialiasing: true
            }
            OpacityMask {
                id: maskImage
                anchors.fill: img
                source: img
                maskSource:imgRect
                visible: true
                antialiasing: true
            }
        }
        CButton{
             id:button
             anchors.left: statusRect.right
             anchors.leftMargin: 10
             //anchors.horizontalCenter: statusRect.horizontalCenter
             //anchors.top:statusRect.top
             anchors.verticalCenter: statusRect.verticalCenter
             height: 50
             width: height
             radius: height/2
             border.width: 2
             text: "抽奖"
             onClick : {
                 drawStatus = !drawStatus
             }
        }
        Rectangle{
            color: "transparent"
            id:statusRect
            anchors.top: imgRect.top
            anchors.left: imgRect.right
            anchors.leftMargin: 10
            height: imgRect.height
            width: 170
            //border.width: 1
            Text {
                id: nameText
                anchors.top: statusRect.top
                anchors.topMargin: parseInt(statusRect.height/10)
                anchors.left: statusRect.left
                anchors.leftMargin: 20
                height: parseInt(statusRect.height/4)
                text: qsTr("一头宝宝")
                font.pointSize: 15
                verticalAlignment: Text.AlignVCenter
            }
            Column{
                anchors.top:nameText.bottom
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 1
                width: parent.width-2
                x:1
                Repeater{
                    model:["今日积分","今日喝水","猪头幸福度"]
                    CLable{
                        color: "transparent"
                        height: parent.height/3
                        width: parent.width
                        leftText: modelData
                        rightText: "100"
                    }
                }
            }
        }
        Loader{
            x:0
            y:150
            height: 250
            width: rootWin.width
            sourceComponent: loaderRect
            visible: drawStatus
            onLoaded: {
                console.log("log")
            }
        }
    }
    Component{
        id:loaderRect
        Rectangle{
            anchors.fill: parent
            border.width: 2
            MainDraw{
                Rectangle{
                    id:drawTextRect
                    x:0
                    y:0
                    width: parent.width
                    height: 30
                    border.width: 3
                    border.color:Qt.rgba(Math.random(), Math.random(), Math.random(), 1)
                    Text{
                        id:drawText
                        font.bold: true
                        font.pixelSize: 12
                        anchors.fill: parent
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        text:"欢迎来到猪头的抽奖乐园"
                        color:Qt.rgba(Math.random(), Math.random(), Math.random(), 1)
                    }
                    ColorAnimation{
                        id:backGroudAnimation
                        loops: Animation.Infinite
                        target: drawRect
                        property: "color"
                        to:Qt.rgba(Math.random(), Math.random(), Math.random(), 1)
                        duration: 1000
                    }
                    ColorAnimation{
                        loops: Animation.Infinite
                        id:textColorAnimation
                        target: drawText
                        property: "color"
                        to:Qt.rgba(Math.random(), Math.random(), Math.random(), 1)
                        duration: 1000
                    }
                }
                id:drawRect
                anchors.fill: parent
                gridX: (rootWin.width-gridWidth)/4
                gridY: 40
                buttonWidth: 60
                buttonMargin: 15
                onVisibleChanged: {
                    if(visible){
                        randomModel()
                        backGroudAnimation.start()
                        textColorAnimation.start()
                    }
                }
            }
        }
    }
}
