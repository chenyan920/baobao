import QtQuick 2.12

Rectangle {
    width: 120
    height: 370

    function setModel(timeArray){
        var index = timeArray.length - 1
        timeModel.set(index, {"time":timeArray[index]})
    }
    ListModel{
        id:timeModel
    }
    ListView {
        id: listview;
        anchors.fill: parent;
        anchors.margins: 0
        model: timeModel ;
        spacing: 5
        clip: true
        boundsBehavior: Flickable.StopAtBounds
        delegate: numberDelegate;
        snapMode: ListView.SnapToItem
        header: Rectangle {
            width: 120; height: 20; color: "#b4d34e"
            Text {
                anchors.centerIn: parent; text: "喝水时间"
            }
        }
//        footer: Rectangle {
//            width: 120; height: 20; color: "#797e65"
//            Text {
//                anchors.centerIn: parent; text: "footer"
//            }
//        }
//        highlight: Rectangle {
//            color:listview.focus?'white': "black"; radius: 5 ; opacity: 0.5; z:5
//        }
        focus: true; keyNavigationWraps :true
        highlightMoveVelocity: 1000
    }
    Component {
        id: numberDelegate
        Rectangle {
            id: wrapper; width: 120; height: 25;
//            color: ListView.isCurrentItem ? "white" : "lightGreen"
            Text {
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 9;
                property int sum : index + 1
                text: "第"+sum+"次:"+time
               // color: wrapper.ListView.isCurrentItem ? "blue" : "white"
            }
        }
    }
    Connections{
        target: drinkWindow
        enabled:visible
        onOverDrink:{
            console.log("connect ready")
            console.log(timerTool.drinkTime)
            setModel(timerTool.drinkTime)
        }
    }
}
