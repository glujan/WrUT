import QtQuick 1.0

Rectangle {
    width: 600
    height: 300
    gradient: Gradient {
        GradientStop {
            position: 0.00;
            color: "#dff5f5";
        }
        GradientStop {
            position: 0.71
            color: "#add8e6";
        }
        GradientStop {
            position: 0.75;
            color: "#006400";
        }
        GradientStop {
            position: 1.00;
            color: "#509910";
        }
    }
    Image {
        id: ball
        source: "ball.svg"
        smooth:  true
        height: 64; width: 64
        x: 20; y: 200
        MouseArea {
            anchors.fill: parent;
            onClicked: ball.state=="roll" ? ball.state="running" : ball.state="roll"
        }
        state: "roll"

        states: [
            State {
                name: "running"
                PropertyChanges {target: ball}
            },
            State {
                name: "roll"
                PropertyChanges { target: ball}
            }
        ]
        transitions: [
            Transition {
                from: "roll"; to: "running"
                ParallelAnimation {
                    NumberAnimation { target: ball; property: "x"; easing.type: Easing.OutQuad; from: 20; to: 500; duration: 1250 }
                    SequentialAnimation {
                        NumberAnimation { target: ball; property: "y"; easing.type: Easing.OutQuad; from:200; to: 20; duration: 250 }
                        NumberAnimation { target: ball; property: "y"; easing.type: Easing.OutBounce; from:20; to: 200; duration: 1000 }
                    }
                    SequentialAnimation {
                        RotationAnimation {
                            target: ball; property: "rotation"; from: 0; to: 360
                            direction: RotationAnimation.Clockwise; duration: 1000
                        }
                        RotationAnimation {
                            target: ball; property: "rotation"; from: 360; to: 380
                            direction: RotationAnimation.Clockwise; duration: 250
                        }
                    }
                }
            },
            Transition {
                from: "running"; to: "roll"
                ParallelAnimation {
                    NumberAnimation { target: ball; property: "x"; easing.type: Easing.OutQuad; from: 500; to: 20; duration: 1250 }
                    RotationAnimation {target: ball; property: "rotation"; from: 0; to: -530;
                        direction: RotationAnimation.Counterclockwise; duration: 1250;}
                }
            }
        ]
    }
}
