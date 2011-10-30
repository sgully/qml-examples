import QtQuick 1.0
import "myjavastuff.js" as JS

Rectangle {
    id: mvc_window
    width: 350
    height: 500

    // Header panel
    Rectangle {
        id: mvc_header
        width: parent.width
        height: 120
        color: "yellow"
        Text {
            anchors.centerIn: parent
            text: "List View"
            color: "red"
            font.pointSize: 32
        }

    }

    // 1. Datamodel - this supplies the data rows
    //  - here it's contained within the QML,
    //    but can come from other sources - eg a database
    ListModel {
        id: mvc_model
        ListElement {
            name: "John Smith"
            age: 31
        }
        ListElement {
            name: "Mary Brown"
            age: 49
        }
        ListElement {
            name: "Brian Jones"
            age: 19
        }
    }

    // 2. Delegate - this describes how to handle each row of data
    Component {
        id: mvc_delegate
        Row {
            Text {
                id: mvc_name
                text: qsTr("Name: ") + name
                width: 250
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        mvc_listview.currentIndex = index
                        console.debug("Clicked on name")
                    }
                }
            }
            Text {
                id: mvc_age
                text: qsTr("Age: ") + age
                width: mvc_header - mvc_name.width
                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        mvc_listview.currentIndex = index
                        console.debug("Clicked on age")
                        JS.doSomething()  // Javascript from file
                    }
                }
            }
        }
    }


    // 3. ListView - this displays the rows as a list.
    Rectangle {
        // Put the ListView inside a rectangle for more layout control
        color: "blue"
        anchors.top: mvc_header.bottom
        anchors.bottom: mvc_window.bottom
        width: mvc_window.width
        ListView {
            id: mvc_listview
            anchors.fill: parent
            model: mvc_model
            delegate: mvc_delegate
            highlight: Rectangle {
                color: "lightsteelblue"
                width: mvc_listview.width
                radius: 5
            }
            focus: true

        }
    }
}
