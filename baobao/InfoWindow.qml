
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
                  "2020.04.16 V1.0.1 (1)修正win7系统下时间显示BUG (2)增加每日积分兑换功能\n"+
                  "2020.05.20 上线猪猪工厂游戏，规则如下：\n"+
"    1.打击臭猪（哼哼猪，略略猪，哦哦猪）加20分，被臭猪逃跑扣10分\n"+
"    2.打击香猪扣10分，香猪不被打击时每次出现加5分\n"+
"    3.放过臭猪以及打击香猪会使血量减少10（100满，为0时游戏结束）\n"+
"    4.游戏在20s后进入困难模式，每次出现两头猪\n"+
"    5.困难模式下每坚持10s，分数增加50\n"
        }
    }
}
