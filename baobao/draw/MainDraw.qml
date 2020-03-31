import QtQuick 2.9
import QtQuick.Window 2.2

Window {
    property int sum: 0
    property int count: 0
    property int runningTimes: 0
    property int prize: 0
    property var probability: [5,10,20,20,45]
    property var proResult: [0,0,0,0,0]
    property var jackpotName: ["一","二","二","三","三","四","四","五","五","五"]

    function arrayAdd(array,num){
        var result = 0
        for(var i=1;i<=num;i++){
            result += array[i-1]
        }
        return result
    }

    function randomJackpot(array){ // 奖池随机排列
        var result = []
        var tempArray = []
        tempArray = array.slice(0,array.length)//数组不能直接=连接，否则只是改名
        var length = tempArray.length
        for(var i=0;i<length;i++){
            var num = Math.floor(Math.random()*tempArray.length)
            result.push(tempArray[num])
            tempArray.splice(num,1)
        }
        return result
    }

    function random(){ //获取本次获得几等奖
        var randomNum
        randomNum = Math.floor(Math.random()*100)
        if(randomNum <= probability[0]){
            proResult[0] += 1
            return [1,randomNum]
        }
        else if(arrayAdd(probability,1)<=randomNum&&randomNum<=arrayAdd(probability,2)){
            proResult[1] += 1
            return [2,randomNum]
        }
        else if(arrayAdd(probability,2)<=randomNum&&randomNum<=arrayAdd(probability,3)){
            proResult[2] += 1
            return [3,randomNum]
        }
        else if(arrayAdd(probability,3)<=randomNum&&randomNum<=arrayAdd(probability,4)){
            proResult[3] += 1
            return [4,randomNum]
        }
        else if(arrayAdd(probability,4)<=randomNum&&randomNum<=arrayAdd(probability,5)){
            proResult[4] += 1
            return [5,randomNum]
        }
    }
    function consoleInfo(){
        console.log(jackpotName , randomJackpot(jackpotName))
        console.log(random())
        console.log(proResult)
        console.log("result"+arrayAdd(probability,1))
        console.log("result"+arrayAdd(probability,2))
        console.log("result"+arrayAdd(probability,3))
        console.log("result"+arrayAdd(probability,4))
        console.log("result"+arrayAdd(probability,5))
    }
    function timingCounting(){ // 根据获奖在奖池的索引获得运动时间
        var baseCount = 20
        prize = random()[0]
        var array = repeater.model.slice(0,jackpotName.length)
        var randomArray = arrayFind(array,prize)
        var randomCount = randomArray[Math.floor(Math.random()*randomArray.length)]
        console.log(prize,randomArray,randomCount)
        return baseCount + randomCount
    }
    function arrayFind(array,key){ // 寻找本次获奖在奖池中的索引
        var keyChar = ""
        switch(key){
        case 1 : keyChar = "一";break;
        case 2 : keyChar = "二";break;
        case 3 : keyChar = "三";break;
        case 4 : keyChar = "四";break;
        case 5 : keyChar = "五";break;
        }
        var result = []
        var index = array.indexOf(keyChar)
        result.push(index)
        while(index <= array.length){
             index = array.indexOf(keyChar,index+1)
             result.push(index)
             if(index === -1){
                 break ;
             }
        }
        result.splice(result.length-1,1)
        return result
    }

    visible:true
    width: 640
    height: 480
    title: qsTr("Hello World")


    Rectangle{
        onVisibleChanged: {
            if(!visible){
                repeater.model = randomJackpot(jackpotName)
            }
        }

        id:gridRootRect
        x:parent.width/2 - width/2
        y:20
        width: 50*5+10*4+10
        height: 50*2+10*1+10
        border.width: 2
        color: "#66225588"
        Grid{
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width-10
            height: parent.height-10
            x:0
            y:0
            rows:2
            columns: 5
            rowSpacing: 10
            columnSpacing: 10
            Repeater{
                id:repeater
                model:jackpotName
                COneDraw{
                    onClick:console.log(index)
                    text: modelData
                    border.color: index===sum?"red":"black"
                    border.width: index===sum?5:2
                }
            }
        }
    }
    CButton{
        id:startButton
        text: "start"
        anchors.top: gridRootRect.bottom
        anchors.topMargin: 30
        anchors.horizontalCenter: gridRootRect.horizontalCenter
        onClick: {
            sum = 0
            count = 0
            runningTimes = timingCounting()
            timer.start()
            console.log("result: "+arrayFind(repeater.model,5))
           // consoleInfo()
        }
    }
    Timer{
        id:timer
        interval: 50
        repeat: true
        onTriggered: {
            //console.log(runningTimes,count)
            sum += 1
            count += 1
            if(sum>9){sum = 0}
            if(count === runningTimes){
                stop()
                text.text += "获得"+prize+"等奖\n"
            }
        }
    }
    Rectangle{
        width: 20
        height: 20
        x:0
        y:0
        color: "red"
        MouseArea{
            anchors.fill: parent
            onClicked: {
                gridRootRect.visible = !gridRootRect.visible
            }
        }
    }
    Rectangle{
        y:parent.height/2
        x:0
        height: parent.height/2
        width: parent.width
        border.width: 1
        Text{
            id:text
            horizontalAlignment: Text.AlignHCenter
            font.pointSize: 15
            font.bold: true
            anchors.fill: parent
        }
    }
}
