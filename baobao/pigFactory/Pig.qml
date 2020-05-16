import QtQuick 2.12

Rectangle {
    property var deviation_X
    property var deviation_Y
    property bool behaviorEnable: false
    property alias pigSource: pigImage.source
    property alias mouseAreaEnable: mouseArea.enabled
    property bool needClick: true
    property bool hasBeenClicked: false
    signal readyBottom()
    signal readyTop()
    id:rootRect
    x:0;y:0
    color: "transparent"
    function showPig(){
        pigRect.y = 0
    }
    function takeBackPig(){
        pigRect.y = pigRect.height*2/3
    }
    function setRectVisible(bool){
        signalRect.visible = bool
    }
    function setScoreText(){
        scoreRect.visible = true
        if(needClick) {scoretext.text = "+20";score+=20}
        else {scoretext.text = "-10";score-=10}
    }
    function initStatus(){
       scoretext.text = ""
       hasBeenClicked = false
       signalRect.visible = false
       behavior.enabled = true
       mouseArea.enabled = true
    }
    function bottomDeal(){
         if(hasBeenClicked){
             if(needClick) {
                 signLabel.text = "成功赶跑了臭猪!  积分+20"
                 statusBar.setFromGame(0)
             }else{
                 signLabel.text = "你居然赶走了可爱的猪!  积分-10"
                 statusBar.setFromGame(2)
                 statusBar.gameStatus -= 10
             }
         }else{
             if(needClick){
                 score-=20
                 signLabel.text = "哈哈!臭猪猪被放过了！ 积分-20"
                 statusBar.setFromGame(1)
                 statusBar.gameStatus -= 10
             }else {
                 score+=5
                 signLabel.text = "你看到了可爱的猪呢！积分+5"
                 statusBar.setFromGame(3)
             }
         }
         scoreInfo.setScore(score)
    }
    Rectangle{
        id:gameRect
        x:Math.random()*deviation_X
        y:Math.random()*deviation_Y
        height: parent.height*0.7
        width: parent.width*0.7
        border.width: 0
        color: "transparent"
        clip: true
        Rectangle{
            id:pigRect
            width: parent.width
            height: parent.height
            x:0
            y:height/3*2
            color: "transparent"
            Behavior on y{
                id:behavior
                enabled: behaviorEnable
                NumberAnimation{
                    duration:timeSetting.popTime
                }
            }
            onYChanged: {
                if(inRunning){
                    if(y>=height/3*2){
                        scoretext.text = ""
                        readyBottom()
                        signLabel.text = "show one pig"
                        bottomDeal()
                    }
                    else if(y === 0){
                        readyTop()
                    }
                }
            }
            Image {
                id: pigImage
                anchors.top: parent.top
                width: parent.width
                height: parent.height/3*2
                Rectangle{
                    id:signalRect
                    anchors.fill: parent
                    color: needClick?"transparent":"red"
                    opacity: 0.3
                    visible: false
                }
                MouseArea{
                    id:mouseArea
                    anchors.fill: parent
                    onClicked:{
                        mouseArea.enabled = false
                        signalRect.visible = true
                        hasBeenClicked = true
                        setScoreText()
                        hammer.retateHammer()
                    }
                }
                Rectangle{
                   id:scoreRect
                   anchors.horizontalCenter: parent.horizontalCenter
                   anchors.verticalCenter: parent.verticalCenter
                   anchors.horizontalCenterOffset: 15
                   anchors.verticalCenterOffset: -15
                   width: 20
                   height: 10
                   color:"transparent"
                   Text {
                       id: scoretext
                       font.pointSize: 15
                       verticalAlignment: Text.AlignVCenter
                       horizontalAlignment: Text.AlignHCenter
                       anchors.fill: parent
                   }
                }
            }
        }
        Image {
            id:image
            width: parent.width
            height:parent.height/3
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            source: "timg.jpeg"
        }
    }
}

