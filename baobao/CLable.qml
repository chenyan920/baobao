import QtQuick 2.0

Rectangle {
     id:rootRect
     property alias leftText: leftText.text
     property alias rightText: rightText.text
     property bool buttonVisible:false
     signal buttonClicked()
     Text{
         id:leftText
         anchors.top:parent.top
         anchors.left: parent.left
         height: parent.height
         verticalAlignment: Text.AlignVCenter
         horizontalAlignment: Text.AlignLeft
         width: parent.width/2
         CButton{
             visible: buttonVisible
             radius: height/2
             height: parent.height/3*2
             width: height
             border.width: 1
             x:parent.contentWidth + 5
             text:"!"
             anchors.verticalCenter: parent.verticalCenter
             onClick: buttonClicked()
         }
     }
     Text{
         id:rightText
         anchors.top:parent.top
         anchors.right: parent.right
         height: parent.height
         verticalAlignment: Text.AlignVCenter
         horizontalAlignment: Text.AlignRight
         width: parent.width/2
     }
}
