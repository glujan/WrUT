import QtQuick 1.0

Rectangle {
    width: 360; height: 360
    Rectangle {
        id: box
        width: parent.width*1/2
        height: parent.height
        color: "lightgrey"
        Rectangle {
            width: parent.width-10
            height: parent.height-10
            color: "grey"
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            Rectangle {
                id: suwak
                width: parent.width -10
                height: parent.width -10
                color: "lightgrey"
                y:5
                x: 5
                MouseArea{
                    id: suwak_mouse
                   anchors.fill: parent
                   onClicked: parent.state == "off" ? suwak.state = "on" : parent.state = "off"
                }
                state: "off"
                states:[
                    State {
                        name: "on"
                        PropertyChanges { target: swiatlo; color: "yellow"}
                        PropertyChanges {target: suwak; y: 185}
                    },
                    State{
                        name: "off"
                        PropertyChanges { target: swiatlo; color: "black"}
                        PropertyChanges {target: suwak; y: 5}
                    }

                ]
                transitions: Transition {
                    from: "on"; to: "off"
                    reversible: true
                    ColorAnimation {target: swiatlo; duration: 800}
                    NumberAnimation { target: suwak; property: "y"; duration: 800 }
                }
            }
        }
    }
    Rectangle {
        id: swiatlo
        width: 120; height: 120
        radius: 20
        color: "black"
        anchors.verticalCenter: parent.verticalCenter
        anchors.left: box.right; anchors.leftMargin: 10
    }

}
