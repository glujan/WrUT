import QtQuick 1.0

Rectangle {
    width: 310
    height: 310

    ListModel {
        id: icons
        ListElement {
            height: 90; width: 90
            name: "debian"
            icon: "./images/debian.png"
            smooth: true
        }
        ListElement {
            height: 90; width: 90
            name: "fedora"
            icon: "./images/fedora.png"
            smooth: true
        }
        ListElement {
            height: 90; width: 90
            name: "gentoo"
            icon: "./images/gentoo.png"
            smooth: true
        }
        ListElement {
            height: 90; width: 90
            name: "mandriva"
            icon: "./images/mandriva.png"
            smooth: true
        }
        ListElement {
            height: 90; width: 90
            name: "tux"
            icon: "./images/tux.png"
            smooth: true
        }
        ListElement {
            height: 90; width: 90
            name: "redhat"
            icon: "./images/redhat.png"
            smooth:true
        }
        ListElement {
            height: 90; width: 90
            name: "slack"
            icon: "./images/slack.png"
            smooth: true
        }
        ListElement {
            height: 90; width: 90
            name: "suse"
            icon: "./images/suse.png"
            smooth: true
        }
        ListElement {
            height: 90; width: 90
            name: "ubuntu"
            icon: "./images/ubuntu.png"
            smooth: true
        }
    }

    GridView {
        id: kratka
        width: parent.width; height: parent.height
        //        columns: 3
        //        rows: 3
        //     spacing: 10
        x:10; y:10
        cellHeight: 90; cellWidth: 90



        model: icons
        delegate: Column {
            Image {
                id: name
                source: icon;
                anchors.horizontalCenter: parent.horizontalCenter
                state: "minimized"
                x:10; y:10; z:0

                MouseArea{
                    anchors.fill: parent
                    hoverEnabled: true
                    anchors.left: parent.left; anchors.leftMargin: 10
                    anchors.top: parent.top; anchors.topMargin: 10
                    // onHoveredChanged: parent.scale==1 ? parent.scale=1.2 : parent.scale=1
                    onHoveredChanged: name.state == "minimized" ? name.state="raised" : name.state= "minimized"
                    onClicked: name.state == "raised" ? name.state="maximized" : name.state = "raised"
                }
                focus: MouseArea.containsMouse ? true : false
                //state: MouseArea.containsMouse ? "raised" :"minimized"

                states: [
                    State {
                        name: "minimized"
                        PropertyChanges {target: name; scale: 1}
                    },
                    State {
                        name: "raised"
                        PropertyChanges { target: name; scale:1.1}
                    },
                    State {
                        name: "maximized"
                        PropertyChanges { target: name; scale: 3; z:1}
                    }
                ]
                transitions: [
                    Transition {
                        from: "minimized"; to: "raised"
                        reversible: true
                        PropertyAnimation { target: name ; property: "scale";  duration: 200 }

                    },
                    Transition {
                        from: "raised"; to: "maximized"
                        reversible: true
                        PropertyAnimation {
                            target: name ; property: "scale"; duration: 200
                        }
                        PropertyAnimation {
                            target: name ; property: "scale"; duration: 200
                        }
                        PropertyAnimation {
                            target: name ; property: "z"; to:1; duration: 200
                        }
                    }
                ]
            }
        }
    }


}


