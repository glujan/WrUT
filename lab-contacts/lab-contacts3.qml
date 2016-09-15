import QtQuick 1.0

Rectangle {
    width: 300; height: 200; color: "white"

    ListModel {
        id: nameModel
        ListElement { name: "Alice"; file: "../images/star.svg" }
        ListElement { name: "Bob"; file: "../images/night.svg" }
        ListElement { name: "Jane"; file: "../images/star.svg" }
        ListElement { name: "Harry"; file: "../images/star.svg" }
        ListElement { name: "Wendy"; file: "../images/night.svg" }
    }
    Component {
        id: nameDelegate
        Item {
            id: delegateItem
            width: parent.width
            height: pozycja.font.pixelSize

            Text {
                id: pozycja
                text: name
                color: "black"
                font.pixelSize: 20//delegateItem.ListView.isCurrentItem ? 30 : 20
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter                
            }

            Image {
                source: file
                fillMode: Image.PreserveAspectFit
                smooth: true
                sourceSize: Qt.size(64,64)

                width: height; height: parent.height - 4
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
            }

            states: State {
                name: "zaznaczony"
                when: ListView.isCurrentItem
                PropertyChanges {target: pozycja; font.pixelSize: 30}
                PropertyChanges {target: pozycja; color: "red"}
            }
            transitions: Transition{
                from: "*"; to: "zaznaczony"
                reversible: true
                NumberAnimation {
                    properties: "font.pixelSize";
                    easing.type: Easing.InOutQuint
                    duration: 400
                }
                ColorAnimation { duration: 400 }
            }
        }
    }

    ListView {
        id: listView
        anchors.fill: parent

        model: nameModel
        delegate: nameDelegate
        focus: true
        clip: true

        header: Rectangle {
            width: parent.width; height: 10;
            color: "#8080ff"
        }
        footer: Rectangle {
            width: parent.width; height: 10;
            color: "#8080ff"
        }
        highlight: Rectangle {
            id: podswietlenie
            height: 10;
            color: "lightgray"
        }
    }
}
