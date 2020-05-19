import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    property bool inRunning: false
    property bool allreadyStart: false
    property int score: 0
    property int gameDifficulty: 1
    property bool changeDiffculty : false
    property var currentPopIndex:[0]
    property var timeArray: [0,0,0]
    property bool readyGame: false

    signal gameOver()
    color: "#C1FFC1"

    visible: true
    width: 640
    height: 520
    x:(Screen.width - width)/2
    y:(Screen.height - height)/2

    title: qsTr("欢迎来到宝宝的养猪厂！(test)")

    function popPig(){
        if(!readyGame) return;
        signLabel.text = ""
        var randomNum = Math.floor(Math.random()*6)
        currentPopIndex[0] = randomNum
        repeater.itemAt(randomNum).initStatus()
        var temp = setProperty()
        repeater.itemAt(randomNum).pigSource = temp[0]
        repeater.itemAt(randomNum).needClick = temp[1]
        repeater.itemAt(randomNum).showPig()
        timer.start()
    }
    function doublePopPig(){
        if(!readyGame) return;
        signLabel.text = ""
        var randomArray = [Math.floor(Math.random()*3),Math.floor(Math.random()*3)+3]
        currentPopIndex = [].concat(randomArray)
        repeater.itemAt(randomArray[0]).initStatus()
        repeater.itemAt(randomArray[1]).initStatus()
        var temp = setProperty()
        repeater.itemAt(randomArray[0]).pigSource = temp[0]
        repeater.itemAt(randomArray[0]).needClick = temp[1]
        repeater.itemAt(randomArray[0]).showPig()
        temp = setProperty()
        repeater.itemAt(randomArray[1]).pigSource = temp[0]
        repeater.itemAt(randomArray[1]).needClick = temp[1]
        repeater.itemAt(randomArray[1]).showPig()
        timer.start()
    }
    function setProperty(){
        var temp = Math.floor(Math.random()*6)
        switch(temp){
        case 0 : return ["bang.png",false]
        case 1 : return ["heng.png",true]
        case 2 : return ["lue.png",true]
        case 3 : return ["meme.png",false]
        case 4 : return ["mua.png",false]
        case 5 : return ["o.png",true]
        }
    }
    function resetAll(){
        timeSetting.popTime = 200
        timeSetting.showTime = 800
        gameDifficulty = 1
        statusBar.resetStatus()
        timeArray = [0,0,0]
        console.log(timeArray)
        scoreInfo.resetScore()
        gameOverRect.visible = false
        startButton.enabled = true
        score = 0
    }
    onGameOver: {
        readyGame = false
        startButton.enabled = false
        timer.stop()
        timer2.stop()
        timer3.stop()
        timer4.stop()
        scoreInfo.setTime(timeArray)
        gameOverRect.visible = true
        console.log(timeArray)
    }
    Rectangle{
        id:buttonStart
        width: 60;height: 36
        z:100
        radius: 10
        anchors.verticalCenter:statusBar.verticalCenter
        anchors.left: scoreInfo.right
        anchors.leftMargin: 16
        color: "#C0FF3E"
        Text {
            id: name1
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text: qsTr("START")
        }
        MouseArea{
            id:startButton
            anchors.fill: parent
            hoverEnabled: true
            onEntered: {
                buttonStart.color = "#9ACD32"
            }
            onExited: {
                buttonStart.color = "#C0FF3E"
            }
            onClicked: {
                readyGame = true
                timer3.start()
                allreadyStart = true
                inRunning = true
                if(gameDifficulty === 1)
                    popPig()
                else if(gameDifficulty === 2)
                    doublePopPig()
            }
        }
    }
    StatusBar{
        id:statusBar
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -80
        anchors.top: parent.top
        anchors.topMargin: 5
    }
    ScoreInfo{
        id:scoreInfo
        height: statusBar.height
        anchors.left: statusBar.right
        anchors.leftMargin: 5
        anchors.top: statusBar.top
    }
    Rectangle{
        id:scoreRect
        height: 60
        width: parent.width
        x:0;y:0;
        visible: false

        Text {
            id: name
            anchors.top: parent.top
            height: 30
            width: parent.width
            text: "当前积分:  "+String(score)
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
        Text {
            id: signLabel
            height: parent.height - name.height
            width: name.width
            anchors.top: name.bottom
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            text: "welcome pig factory"
        }
    }
    Timer{
        id:timer
        interval: timeSetting.showTime
        repeat: false
        running: false
        onTriggered: {
            if(gameDifficulty === 1){
                repeater.itemAt(currentPopIndex[0]).takeBackPig()
                timer2.start()
            }
            else if(gameDifficulty === 2){
                repeater.itemAt(currentPopIndex[0]).takeBackPig()
                repeater.itemAt(currentPopIndex[1]).takeBackPig()
                timer2.start()
            }
        }
    }
    Timer{
        id:timer2
        interval: timeSetting.spacingTime
        repeat: false
        running: false
        onTriggered: {
            if(gameDifficulty === 1)
                popPig()
            else if(gameDifficulty === 2)
                doublePopPig()
        }
    }
    Timer{
        id:timer3
        interval: 10
        repeat: true
        running: false
        onTriggered: {
            timeArray[0] += 1
            if(timeArray[0] === 100){
                timeArray[0] = 0
                timeArray[1] += 1
            }
            if(timeArray[1] === 20){
                 timeSetting.showTime = 1000
                 timeSetting.popTime = 100
                 timer4.start()
                 gameDifficulty = 2
            }
            if(timeArray[1] === 60){
                timeArray[1] = 0
                timeArray[2] += 1
            }
            scoreInfo.setTime(timeArray)//what's up????????
        }
    }
    Timer{
        id:timer4
        running: false
        repeat: true
        interval: 10000
        onTriggered: {
            console.log(score)
            score += 50
            console.log(score)
        }
    }
    Rectangle{
        id:rootRect
        anchors{
            fill:parent
            topMargin: 102
            bottomMargin: 10
            rightMargin: 10
            leftMargin: 10
        }
        border.color: "#00EE76"
        border.width: 3
        radius: 5
        clip: true
        MouseArea{
            property point clickPos: "0,0"
            anchors.fill:parent
            hoverEnabled: true
            onEntered: {
                if(allreadyStart){
                    hammer.visible = true
                    hammer.center_X = mouseX
                    hammer.center_Y = mouseY
                }
            }
            onPositionChanged: {
                var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
                hammer.center_X = delta.x
                hammer.center_Y = delta.y
            }
            onExited: {
                hammer.visible = false
            }
        }
        HammerAnimation{
            id:hammer
            z:100
            visible: false
        }
        Image {
            id: backGroundImage
            source: "pigBackGround.jpg"
            anchors.fill: parent
            anchors.margins: 3
        }
        Grid{
            id:grid
            rows: 2
            columns: 3
            columnSpacing: 10
            rowSpacing: 10
            anchors.fill: parent
            anchors.margins: 20
            // clip: true
            Repeater{
                id:repeater
                model:6
                Pig{
                    id:pig
                    deviation_X:parent.width/20
                    deviation_Y: parent.height*3/40
                    height: parent.height/(parent.rows)
                    width: parent.width/(parent.columns)
                }
            }
        }
    }
    TimeSetting{
        id:timeSetting
    }
    Rectangle{
        id:gameOverRect
        anchors.fill: parent
        color: "transparent"
        z:1000
        visible: false
        Rectangle{
            anchors{
                fill:parent
                topMargin: 102
                bottomMargin: 10
                rightMargin: 10
                leftMargin: 10
            }
            color: "#C1FFC1"
            visible: parent.visible
            z:1000
            Text {
                id: gameOverText
                text: qsTr("game\nover")
                font.bold: true
                font.pointSize: 40
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.fill: parent
            }
            Rectangle{
               id:resetRect
               width: 88
               height: 36
               border.width: 2
               radius: 10
               color: "#C0FF3E"
               anchors.horizontalCenter: parent.horizontalCenter
               anchors.verticalCenter: parent.verticalCenter
               anchors.verticalCenterOffset: 120
               Text {
                   id: resetText
                   text: qsTr("o k")
                   verticalAlignment: Text.AlignVCenter
                   horizontalAlignment: Text.AlignHCenter
                   anchors.fill: parent
               }
               MouseArea{
                   anchors.fill: parent
                   hoverEnabled: true
                   onEntered: {
                       resetRect.color = "#9ACD32"
                   }
                   onExited: {
                       resetRect.color = "#C0FF3E"
                   }
                   onClicked: {
                       mouse.accepted = true
                       resetAll()
                       console.log("ok")
                   }
               }
            }
        }
    }
}
