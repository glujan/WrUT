import QtQuick 1.0

Rectangle {
    width: 500
    height: 500
    Rectangle{
        id:lightblue
        width: parent.width/2-20
        height: parent.width/2-20
        color: focus ? "blue" : "lightblue"
        anchors.top: parent.top; anchors.topMargin: 10
        anchors.left: parent.left; anchors.leftMargin: 10
        KeyNavigation.down: lightgrey
        KeyNavigation.right: green
        MouseArea {
            id: lightblue_mouse
            anchors.fill: parent
            onClicked: parent.focus = true
        }

        focus: true
    }

    Rectangle{
        id: lightgrey
        width: parent.width/2-20
        height: parent.width/2-20
        color: focus ? "grey" : "lightgrey"
        anchors.top: lightblue.bottom; anchors.topMargin: 10
        anchors.left: parent.left; anchors.leftMargin: 10
        KeyNavigation.up:lightblue
        KeyNavigation.right:pink
        MouseArea {
            id: lightgrey_mouse
            anchors.fill: parent
            onClicked: parent.focus = true
        }
        focus: lightgrey_mouse.containsMouse ? true : false
    }

    Rectangle{
        id: green
        width: parent.width/2-20
        height: parent.width/2-20
        color: focus ? "darkgreen" : "lightgreen"
        anchors.top: parent.top; anchors.topMargin: 10
        anchors.left: lightblue.right; anchors.leftMargin: 10
        KeyNavigation.down:pink
        KeyNavigation.left:lightblue
        MouseArea {
            id: green_mouse
            anchors.fill: parent
            onClicked: parent.focus = true
        }
        focus: green_mouse.containsMouse ? true : false
    }

    Rectangle{
        id: pink
        width: parent.width/2-20
        height: parent.width/2-20
        color: focus ? "violet" : "pink"
        anchors.top: green.bottom; anchors.topMargin: 10
        anchors.left: lightgrey.right; anchors.leftMargin: 10
        KeyNavigation.up:green
        KeyNavigation.left:lightgrey
        MouseArea {
            id: pink_mouse
            anchors.fill: parent
            onClicked: parent.focus = true
        }
        focus: pink_mouse.containsMouse ? true : false
    }
}
