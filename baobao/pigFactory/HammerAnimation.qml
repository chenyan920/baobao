import QtQuick 2.12

Image {
    function retateHammer(){
        hammer.rotation = -60
    }
    property real center_X : 0
    property real center_Y : 0
    id: hammer
    x:center_X-width/2
    y:center_Y-width/2
    height: 100
    width: height
    source: "hammer.png"
    Behavior on rotation {
        PropertyAnimation{
            duration: 100
        }
    }
    onRotationChanged: {
        if(rotation === -60){
            rotation = 0
        }
    }
}
