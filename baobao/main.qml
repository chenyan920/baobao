import QtQuick 2.9
import QtQuick.Window 2.2
import QtGraphicalEffects 1.0
import "dataInf.js" as DateInf

Window {
    property string imageSource: "normalPig.PNG"

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
            case 1 : return "#A8EE2C2C"
            case 2 : return "#A8EE9A00"
            case 3 : return "#A8EEEE00"
            case 4 : return "#A8B3EE3A"
            case 5 : return "#A8B0E2FF"
            case 6 : return "#A84682B4"
            case 0 : return "#A8551A8B"
            }
        }
        id:rootRect
        anchors.fill:parent
        color:getColor()
        radius: height/2
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
        buttonName: ["想你了猪","打卡喝水","不想见猪","点错了呢","查看宝宝"]
        onMenuClicked: {
            switch(index){
            case 0:testWindow.show();break;
            case 1:drinkWindow.alreadyDrink();break;
            case 2:var string = DateInf.calculateDayToDay(2017,12,30)
                   console.log(string + typeof(string));break;
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
}
