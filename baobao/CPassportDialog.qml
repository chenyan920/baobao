import QtQuick 2.12

Rectangle{
    property var bashCharPassport:setCharPassPort()
    property int bashNumPassport: setBashPassport()[1]
    property string codingTable: "ASDFGHJKL"
    property int recordPoints: 0
    property bool enableGetPoints: true

    function setBashPassport(){
        var baseDate = new Date
        var month = baseDate.getMonth()+1//月份4
        var date = baseDate.getDate()//日子15
        var dayInWeek = baseDate.getDay()//星期3
        var day = Number(String(month)+String(date))//月份+日期415
        var temp1 = day*dayInWeek*(month+date)
        while(temp1<100000){
            temp1 *= (temp1-1)
        }
        var temp2 = Number(String(dayInWeek)+String(day))
        temp1 = String(temp1).slice(-6)
        temp2 = Number(String(temp2*temp2).slice(-6))-1000
        return [temp1,temp2]
    }
    function setCharPassPort(){
        var tempLength = codingTable.length
        var tempString = String(setBashPassport()[0])
        var result = new String
        for(var i=0;i<=4;i++){
            var tempChars = tempString.slice(i,i+2)
            result+=codingTable[(parseInt(tempChars)%tempLength)]
        }
        return result
    }
    function decoding(text){
        if(!enableGetPoints)
            return false
        if(text.length !== 12)
            return false
        if(text.slice(0,5) !== bashCharPassport)
            return false
        var grade
        switch(text[5]){
        case "A":grade = 50;break;
        case "B":grade = 30;break;
        case "C":grade = 20;break;
        case "D":grade = 10;break;
        default:return false
        }
        if(parseInt(text.slice(-6)) === bashNumPassport + grade){
            recordPoints = grade
            drinkPoints += grade
            enableGetPoints = false
            showInfoText.text = "增加"+recordPoints+"积分"
            return true
        }
        else
            return false
    }
    function getPassport(grade){
        var temp
        switch(grade){
        case "A":temp = 50;break;
        case "B":temp = 30;break;
        case "C":temp = 20;break;
        case "D":temp = 10;break;
        default:return false
        }
        var tempNumCode = String(bashNumPassport +temp)
        return bashCharPassport+grade+tempNumCode
    }
    id:root
    color: "#6666660F"
    width: parent.width
    height: parent.height
    onVisibleChanged: {
        if(visible){
            if(!enableGetPoints){
                showInfoText.text = "今日已兑换"+recordPoints+"积分"
                textEdit.text = ""
                textEdit.enabled = false
                button1.enabled = false
            }
            else{
                showInfoText.text =""
            }
        }
    }
    onEnableGetPointsChanged: {
        if(!enableGetPoints){
            showInfoText.text = "今日已兑换"+recordPoints+"积分"
            textEdit.text = ""
            textEdit.enabled = false
            button1.enabled = false
        }
    }
    Rectangle{
        width: 200
        height: width/2.5
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        border.width: 2
        border.color: "#666666"
        radius: 5
        Rectangle{
            id:textRoot
            height: parent.height*2/3
            width: parent.width
            anchors.top: parent.top
            anchors.left: parent.left
            Text {
                id: labelText
                width: parent.width/3
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                height: parent.height
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: "兑换码："
            }
            Rectangle{
                id:textEditRoot
                height: labelText.contentHeight+3
                border.width: 2
                border.color: "#AA00000AA"
                anchors.verticalCenter: labelText.verticalCenter
                width: (parent.width-labelText.width)-10
                x:(parent.width-width-labelText.width)/2 + labelText.width
                TextEdit{
                    id:textEdit
                    anchors.fill: parent
                    anchors.margins: 3
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    enabled: true
                    focus: true
                }
            }
            Text {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: textEditRoot.bottom
                verticalAlignment: Text.AlignTop
                horizontalAlignment: Text.AlignHCenter
                height: 18
                color: "gray"
                id: showInfoText
                text: ""
                font.pointSize: 7
            }
        }
        Rectangle{
            property var buttonPadding: 50
            anchors.top: textRoot.bottom
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.left: parent.left
            CButton{
                id:button1
                height: parent.height-5
                width: parseInt(height*2)
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: parent.buttonPadding
                text: "确认"
                onClick: {
                    if(!decoding(textEdit.text)){
                        showInfoText.text = "密码错误"
                    }
                    console.log(getPassport("A"))
                }
            }
            CButton{
                height: button1.height
                width: parseInt(height*2)
                anchors.verticalCenter: parent.verticalCenter
                anchors.right: parent.right
                anchors.rightMargin: parent.buttonPadding
                text: "关闭"
                onClick: root.visible = false
            }
        }
    }
}
