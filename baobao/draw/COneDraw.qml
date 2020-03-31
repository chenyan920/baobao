import QtQuick 2.0

Rectangle {
    signal click()
    property alias text: textArea.text
    id:rootRect
    height: 50
    width: 50
    color: "white"
    border.width: 2
    border.color: "red"
    Text {
        id:textArea
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        anchors.fill: parent
    }
    MouseArea{
        anchors.fill: parent
        onClicked: click()
    }
}

