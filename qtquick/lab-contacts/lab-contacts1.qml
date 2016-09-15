import QtQuick 1.0

Rectangle {
    width: 300; height: 200; color: "white"


    Component {
        id: highlight
        Rectangle {
            width: 180; height: 20
            color: "lightsteelblue"; radius: 5
            y: list.currentItem.y
            Behavior on y {
                SpringAnimation {
                    spring: 3
                    damping: 0.2
                }
            }
        }
    }

    ListView {
        id: list
        width: 180; height: 200
        model: ListModel {
            id: nameModel
            ListElement { name: "Alice"; file: "../images/star.svg" }
            ListElement { name: "Bob"; file: "../images/night.svg" }
            ListElement { name: "Jane"; file: "../images/star.svg" }
            ListElement { name: "Harry"; file: "../images/star.svg" }
            ListElement { name: "Wendy"; file: "../images/night.svg" }
        }
        delegate: Text { text: name }

        highlight: highlight
        highlightFollowsCurrentItem: false
        focus: true
    }
}
