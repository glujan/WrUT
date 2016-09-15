import QtQuick 1.0

Rectangle {
    width: 500
    height: 500
    Rectangle{
        id:blue
        width: parent.width/2-20
        height: parent.width/2-20
        color: "lightblue"
        anchors.top: parent.top; anchors.topMargin: 10
        anchors.left: parent.left; anchors.leftMargin: 10
    }

    Rectangle{
        id: lightgrey
        width: parent.width/2-20
        height: parent.width/2-20
        color: "lightgrey"
        anchors.top: blue.bottom; anchors.topMargin: 10
        anchors.left: parent.left; anchors.leftMargin: 10
    }

    Rectangle{
        id: green
        width: parent.width/2-20
        height: parent.width/2-20
        color: "green"
        anchors.top: parent.top; anchors.topMargin: 10
        anchors.left: blue.right; anchors.leftMargin: 10
    }

    Rectangle{
        id: violet
        width: parent.width/2-20
        height: parent.width/2-20
        color: "violet"
        anchors.top: green.bottom; anchors.topMargin: 10
        anchors.left: lightgrey.right; anchors.leftMargin: 10
    }

//    states: State {
//        name: "active"
//        ColorAnimation {to: "yellow"; duration: 500 }
//    }
//    transitions: Transition {
//        from: "*"; to: "active"
//        reversible: true
//        ColorAnimation { duration: 500 }
//    }

}
