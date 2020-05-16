import QtQuick 2.9
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0
import "dataInf.js" as DateInf
import "pigFactory"

Window {
    property string imageSource: "normalPig.PNG"
    property int drinkPoints: 0
    property int drinkTimesOnTime: 0
    property int drinkTimesOnSelf: 0

    function outputColor(){
        return rootRect.color
    }
    id:mainWindow
    visible: true
    x:Screen.width-200
    y:50
    width: 100
    height: width
    title: qsTr("Hello World")
    color: "transparent"
    flags: Qt.Window | Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint
    MouseArea {
        property point clickPos: "0,0"
        property bool removeFlag: false//可移动标识
        parent: rootRect
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton|Qt.RightButton
        onPressed: {
            mouse.accepted = true
            if(mouse.button === Qt.LeftButton){
                removeFlag = true
                clickPos  = Qt.point(mouse.x,mouse.y)
            }
        }
        onClicked: {
            menu.close()
        }
        onDoubleClicked: {
            if(mouse.button === Qt.LeftButton){
                menu.x = menu.getMenuX(mouse.x,mainWindow.x,Screen.width)
                menu.y = mouse.y + mainWindow.y
                menu.visible = true
            }
        }
        onReleased: {
            removeFlag = false
        }
        onPositionChanged: {
            if(removeFlag){
                var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
                mainWindow.setX(mainWindow.x+delta.x)
                mainWindow.setY(mainWindow.y+delta.y)
            }
        }
    }
    Rectangle{
        function getColor(){
            var day = DateInf.getDay()
            console.log("day:" + day)
            switch(day){
            case 1 : return "#A8EE2C"
            case 2 : return "#A8EE9A"
            case 3 : return "#A8EEEE"
            case 4 : return "#A8B3EE"
            case 5 : return "#A8B0E2"
            case 6 : return "#A84682"
            case 0 : return "#A8551A"
            }
        }
        id:rootRect
        anchors.fill:parent
        color:getColor()
        radius: height/2
        Rectangle{
            id:copyRect
            anchors.fill: parent
            radius:height/2
            color: parent.color
            z:100
            visible: true
            onOpacityChanged: {
               if(opacity === 0){
                   visible = false
                   console.log("111111111111")
               }
            }
            Text{
                anchors.fill: parent
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: "宝宝好"
            }
            Behavior on opacity{
                id:behavior
                NumberAnimation{
                    duration: 3000
                    easing.type:Easing.InCubic
                }
            }
            Component.onCompleted: {
                copyRect.opacity = 0
            }
        }
        Rectangle{
            id:pig
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            height: parent.height - 10
            width: height
            radius: height/2
            Image {
                id: clockImg
                visible: false
                anchors.fill: parent
                anchors.margins: 2
                clip: true
                smooth: true
                source: imageSource
                sourceSize: Qt.size(parent.size, parent.size)
                antialiasing: true
            }
            OpacityMask {
                id: maskImage
                anchors.fill: clockImg
                source: clockImg
                maskSource:pig
                visible: true
                antialiasing: true
            }
        }
    }
    Menu{
        id:menu
        visible: false
        buttonName: ["想你了猪","打卡喝水","猪猪工厂","功能介绍","查看宝宝"]
        onMenuClicked: {
            switch(index){
            case 1:drinkWindow.alreadyDrink();
                drinkTimesOnSelf += 1
                break;
            case 2:var string = DateInf.calculateDayToDay(2017,12,30)
                   console.log(string + typeof(string));
                   pigFactory.show()
                   break;
            case 3:infoWindow.show();break;
            case 4:baoWindow.show()
            }
        }
    }
    PopWindow{
        id:drinkWindow
        height: mainWindow.height*2
        width: mainWindow.width
        x:mainWindow.x
        y:mainWindow.width + mainWindow.y - 8
    }
    TimerTool{
        id:timerTool
        drinkInterval: 60
        onOneSecond: {
            imageSource = "drinkPig.PNG"
            drinkWindow.animationStart()
        }
    }
    TestWindow{
        id:testWindow
        visible:false
    }
    BaoWindow{
        id:baoWindow
    }
    MainPig{
        id:pigFactory
        visible: false
    }
    InfoWindow{
        id:infoWindow
    }
}
