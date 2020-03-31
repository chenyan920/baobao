import QtQuick 2.0

Rectangle {
    signal click
    property alias text: textArea.text
    id:rootRect
    height: 60
    width: 100
    border.color: "red"
    border.width: 2
    Text {
        id:textArea
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.fill: parent
        font.pixelSize: 15
    }
    MouseArea{
        anchors.fill: parent
        onClicked:{
            click()
            console.log("button clicked")
        }
        onPressed: {
            rootRect.color = "yellow"
        }
        onReleased: {
            rootRect.color = "white"
            console.log("button released")
        }
    }
}
