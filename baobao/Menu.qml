import QtQuick 2.9
import QtQuick.Window 2.2

Window {
    property var buttonName
    signal menuClicked(var index)

    function getMenuX(mouseX,mainWindowX,screenWidth){
        if(mainWindowX+mouseX+rootWindow.width > screenWidth){
            return screenWidth - rootWindow.width - 1
        }
        else{
            return mouseX + mainWindowX
        }
    }

    id:rootWindow
    width: 120
    height: 200
    flags: Qt.Window | Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint
    onVisibleChanged: {
        if(visible){
            closeButton.color = "#DEDEDE"
            x.color = "red"
        }
    }
    Rectangle{
        id:lable
        anchors.top: parent.top
        height:20
        width: parent.width
        color:"#DEDEDE"
        Text {
            x:5
            y:5
            id: lableText
            text: qsTr("干嘛点猪?")
            verticalAlignment: Text.AlignVCenter
            anchors.fill: parent
            font.bold: true
        }
        Rectangle{
            id:closeButton
            anchors.right: parent.right
            height: parent.height
            width: height
            color: parent.color
            MouseArea{
                hoverEnabled: true
                anchors.fill: parent
                onEntered: {
                    closeButton.color = "red"
                    x.color = "white"
                }
                onExited: {
                    closeButton.color = "#DEDEDE"
                    x.color = "red"
                }
                onClicked: {
                    rootWindow.close()
                }
            }
            Text {
                id:x
                anchors.fill: parent
                color: "red"
                text: qsTr("x")
                font.family: "Times New Roman"
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }
    Rectangle{
        id:buttonRect
        anchors.top: lable.bottom
        anchors.right: parent.right
        height: parent.height - lable.height
        width: parent.width
        color: "yellow"
        Column{
            width: parent.width
            height: parent.height
            spacing: 0
            Repeater{
                id:buttonRepeater
                model: buttonName
                Button{
                    height: parent.height / 5
                    addText: modelData
                    onButtonClicked: {
                        rootWindow.close()
                        menuClicked(index)
                        console.log(index)
                    }
                }
            }
        }
    }
}
