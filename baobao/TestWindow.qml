import QtQuick 2.12
import QtQuick.Window 2.11
import QtGraphicalEffects 1.0
import "dataInf.js" as DateInf

Window {
    x:(Screen.width - width)/2
    y:(Screen.height - height)/2
    height: 400
    width:640
    title:"宝宝的页面"
    visible: true
    onVisibleChanged: {
        if(visible){
            mainDraw.randomModel()
        }
    }
    MainDraw{
        id:mainDraw
        x:0
        y:0
        z:100
        visible: true
    }
    Rectangle{
//        function changeState(){
//            if(imgRect.state === "normalPig")
//            {
//               imgRect.state = "drinkPig"
//            }
//            else if(imgRect.state === "drinkPig"){
//                 imgRect.state ="normalPig"
//            }
//        }
        id:imgRect
        x:50;y:25
        height: 100;
        width: 100
        radius: 50
        border.width:2
        border.color: "black"
        //state: "drinkPig"
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
//        states: [
//            State {
//                name: "normalPig"
//                PropertyChanges {
//                    target: img
//                    source:"normalPig.PNG"
//                }
//            } ,
//            State {
//                name: "drinkPig"
//                PropertyChanges {
//                    target: img
//                    source:"drinkPig.PNG"
//                }
//            }
//        ]
//        transitions: [
//            Transition {
//                from: "drinkPig"
//                to: "normalPig"
//                PropertyAnimation{
//                    target: img
//                    duration: 1000
//                }
//            }
//        ]
    }
//    Button{
//        id:button
//        height: width / 2
//        width: parent.width / 3
//        anchors.top: imgRect.bottom
//        anchors.topMargin: 20
//        addText: "changeState"
//        anchors.horizontalCenter: imgRect.horizontalCenter
//        border.width: 2
//        onButtonClicked: {
//            imgRect.changeState()
//            var string = DateInf.getLoctateTime()
//            console.log(string + typeof(string))
//        }
//    }
//    DrinkView{
//        id:drinkView
//        x:parent.width - width - 30
//        y:50
//        z:10
//    }
}
