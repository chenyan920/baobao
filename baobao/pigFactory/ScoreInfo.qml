import QtQuick 2.12

Rectangle {
    id:rootRect
    width: height
    radius: 2
    color: "transparent"
    function setTime(tempTime){
        var time = [].concat(tempTime)
        for(var i=0;i<time.length;i++){
           if(String(time[i]).length === 1){
               time[i] = "0"+String(time[i])
           }
           else{
               continue;
           }
        }
        repeater.itemAt(1).text = String(time[2])+":"+String(time[1])+":"+String(time[0])
    }
    function setScore(score){
        repeater.itemAt(3).text = String(score)
    }
    Grid{
        id:grid
        anchors.fill: parent
        columns: 2
        rows: 2
        Repeater{
            id:repeater
            model: ["","00:00:00","积分",score]
            Text {
                id: repText
                height: parent.height/2
                verticalAlignment: Text.AlignBottom
                horizontalAlignment: {
                    switch(index){
                    case 0:
                    case 2:
                    case 3: return Text.AlignHCenter
                    case 1: return Text.AlignRight
                    }
                }
                bottomPadding: 6
                width: parent.width/2
                text: modelData
                font.bold: true
                font.pointSize: 13
                font.family: "Times New Roman"
                color: "#CD661D"
            }
        }
    }
}
