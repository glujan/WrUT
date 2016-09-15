import QtQuick 1.0

Rectangle {
    id : main
    width: 360
    height: 360

    Rectangle {
        id: snd
        width: parent.width
        height: parent.height/2

        MouseArea {
            id: snd_mouse
            anchors.fill: parent
            hoverEnabled: true
        }
    }

    Rectangle {
        id: thrd
        width: parent.width
        height: parent.height/2
        x: 0
        y: parent.height/2
        color:  "red"

        MouseArea {
            id: thrd_mouse
            anchors.fill: parent
            hoverEnabled: true
        }
    }

    states: [
        State {
            name: "withMouseOn"
            when: snd_mouse.containsMouse==true
            PropertyChanges { target: snd; color: "lightblue"}
            PropertyChanges { target: thrd; color: "black" }
        },
        State {
            name: "withoutMouseOn"
            when: snd_mouse.containsMouse==false
            PropertyChanges { target: snd; color: "black" }
            PropertyChanges { target: thrd; color: "lightblue" }
        }
    ]

    transitions: [
        Transition {
            from: "withMouseOn"; to: "withoutMouseOn"
            reversible: true
            PropertyAnimation {
                target: snd
                properties: "color"
                duration: 800
            }
            PropertyAnimation {
                target: thrd
                properties: "color"
                duration: 1000
            }
        }
    ]
}
