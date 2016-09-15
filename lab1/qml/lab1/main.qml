import QtQuick 1.0

Rectangle {
    width: 460
    height: 360
    gradient: Gradient {
        GradientStop {position: 0.0; color:"white"}
        GradientStop {position: 0.5; color:"black"}
        GradientStop {position: 1.0; color:"yellow"}
    }

    Rectangle {
        id: launch
        width: parent.width/1.5; height: parent.height/3
        radius: 20
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.top
        anchors.verticalCenterOffset: parent.height/3
        gradient: Gradient {
            GradientStop {position: 0.0; color:"pink"}
            GradientStop {position: 0.8; color:"red"}
        }

        Image {
            id: rocket
            smooth:  true
            height: parent.height/2
            fillMode: Image.PreserveAspectFit
            source: "images/rocket.png"
            anchors.left: launch.left
            anchors.leftMargin: 15
            anchors.verticalCenter: launch.verticalCenter
        }
        Text {
            text: "Launch"
            anchors.verticalCenter: launch.verticalCenter
            anchors.left: rocket.right
            anchors.leftMargin: 40
            font.pixelSize: parent.height/3
        }
    }
    Rectangle {
        id: cancel
        width: parent.width/1.5; height: parent.height/3
        radius: 20
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: launch.bottom
        anchors.topMargin: 10
        gradient: Gradient {
            GradientStop {position: 0.0; color:"pink"}
            GradientStop {position: 0.8; color:"red"}
        }

        Image {
            id: button
            smooth:  true
            height: parent.height/2
            fillMode: Image.PreserveAspectFit
            source: "images/clear.svg"
            anchors.left: parent.left
            anchors.leftMargin: 15
            anchors.verticalCenter: parent.verticalCenter
        }
        Text {
            text: "Cancel"
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: button.right
            anchors.leftMargin: 40
            font.pixelSize: parent.height/3
        }

    }

}
