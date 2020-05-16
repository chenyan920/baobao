import QtQuick 2.12

Rectangle {
    id:root
    color: "transparent"

    property alias rightText: rightText.text
    property alias leftText: leftText.text
    property alias leftColor: leftText.color
    Rectangle{
        anchors.verticalCenter: parent.verticalCenter
        width: parent.width-10
        height: parent.height*2/3
        border.color: "#90EE90"
        color: "transparent"
        border.width: 1
        radius: height/2
        Text {
            id: leftText
            text: "name"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.left: parent.left
            height: parent.height
            width: parent.width*2/3
            onColorChanged: {
                 timer1.start()
            }
            Timer{
               id:timer1
               interval: 360
               running: false
               repeat: false
               onTriggered: {
                  leftText.color = "black"
               }
            }
        }
        Text{
            id: rightText
            text: String(0)
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
            anchors.right: parent.right
            anchors.rightMargin: parent.height/2+1
            height: parent.height
            width: parent.width/3
        }
    }
}
