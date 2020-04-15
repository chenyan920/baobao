
import QtQuick 2.12
import QtQuick.Window 2.12

Window {
    height: 640
    width: 480
    visible: false
    title: "版本信息V1.0.1"
    Rectangle{
        anchors.fill: parent
        id:rootRect
        Text {
            id: text
            wrapMode: Text.WrapAnywhere
            anchors.margins: 5
            anchors.fill: parent
            text: "2020.04.07 V1.0.0 测试版发布\n"+
                  "2020.04.16 V1.0.1 (1)修正win7系统下时间显示BUG (2)增加每日积分兑换功能"
        }
    }
}
