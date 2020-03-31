import QtQuick 2.0

Rectangle {
    property var addText
    property alias textHorAlignment: buttonText.horizontalAlignment
    property bool textSpace: true
    property string addColor: "white"
    signal buttonClicked()

    id:rootRec
    width: parent.width
    color: addColor
    Text{
        id:buttonText
        anchors.fill: parent
        text: textSpace ? "   " + addText : addText
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
    }
    MouseArea{
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            rootRec.color = "#E0FFFF"
        }
        onExited: {
            rootRec.color = addColor
        }
        onClicked: {
            buttonClicked()
        }
    }
}
