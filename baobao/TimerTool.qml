import QtQuick 2.12

Item {
    property var drinkTime: new Array//声明类型需要靠赋值或new array
    property int second: 0
    property int minute: 0
    property int drinkInterval
    signal oneSecond()
    signal connectSig()

    function timeRefresh(){
        second = 0;
        minute = 0;
    }
    function timerStart(){
        timer.start()
    }
    function timerStop(){
        timer.stop()
    }
    function drinkTimePush(time){
        drinkTime.push(time)
    }

    onDrinkTimeChanged: {
        console.log("------------------" + drinkTime)
        connectSig()
    }

    Timer{
        id:timer
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
             second += 1
             if(second === 60){
                 minute += 1
                 second = 0
             }
             if(minute === drinkInterval){
                 timer.stop()
                 oneSecond()
             }
             //console.log("minute:"+minute+"  second:"+second + "drinkInterval:"+drinkInterval)
        }
    }
}
