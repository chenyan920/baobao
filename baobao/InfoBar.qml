import QtQuick 2.0

Rectangle {
    property alias text: text.text

    Text {
        id: text
        x:0;y:0
        height: parent.height
        width: parent.width/4
    }
}
