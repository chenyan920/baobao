import QtQuick 2.0

Rectangle {
     id:rootRect
     property alias leftText: leftText.text
     property alias rightText: rightText.text
     Text{
         id:leftText
         anchors.top:parent.top
         anchors.left: parent.left
         height: parent.height
         verticalAlignment: Text.AlignVCenter
         horizontalAlignment: Text.AlignHCenter
         width: parent.width/2
     }
     Text{
         id:rightText
         anchors.top:parent.top
         anchors.right: parent.right
         height: parent.height
         verticalAlignment: Text.AlignVCenter
         horizontalAlignment: Text.AlignHCenter
         width: parent.width/2
     }
}
