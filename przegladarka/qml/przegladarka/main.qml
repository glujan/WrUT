import QtQuick 1.0



Rectangle {
    width: 320
    height: 320

    ListModel {
        id: icons
        ListElement {
            name: "debian"
            icon: "./images/debian.png"
            smooth: true
        }
        ListElement {
            name: "fedora"
            icon: "./images/fedora.png"
            smooth: true
        }
        ListElement {
            name: "gentoo"
            smooth: true
            source: "./images/gentoo.png"
        }
        ListElement {
            name: "mandriva"
            smooth: true
            source: "./images/mandriva.png"
        }
        ListElement {
            name: "tux"
            smooth: true
            source: "./images/tux.png"
        }
        ListElement {
            name: "redhat"
            source: "./images/redhat.png"
        }
        ListElement {
            name: "slack"
            smooth: true
            source: "./images/slack.png"
        }
        ListElement {
            name: "suse"
            smooth: true
            source: "./images/suse.png"
        }
        ListElement {
            name: "ubuntu"
            smooth: true
            source: "./images/ubuntu.png"
        }
    }

    GridView {
        id: kratka
        width: parent.width; height: parent.height
        //        columns: 3
        //        rows: 3
        //        spacing: 10
        x:10; y:10
        model: icons
        delegate: Column {
            Image { source: icon; anchors.horizontalCenter: parent.horizontalCenter }
        }

        //        anchors.top: parent.top; anchors.topMargin: 10;
        //        anchors.bottom: parent.top; anchors.bottomMargin: 10;


    }

    states: [
        State {
            name: "minimized"
            PropertyChanges {target: GridView.currentItem}
        },
        State {
            name: "raised"
            PropertyChanges { target: GridView.currentItem}
        }
    ]
}


