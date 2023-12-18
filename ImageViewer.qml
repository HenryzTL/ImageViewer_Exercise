import QtQuick
import QtQuick.Layouts
import "./content"

Rectangle {
    id: mainRect
    width: 640
    height: 480
    visible: true
    color: "#999999"

    ColumnLayout {
        anchors.fill: parent

        TopBar {
            id: topbar
            Layout.alignment: Qt.AlignTop
        }

        // RowLayout {
        //     Layout.fillHeight: true
        //     anchors.fill: parent

        //     // Left Section (ListView)
        //     Rectangle {
        //         Layout.preferredWidth: parent.width * 0.3
        //         Layout.fillHeight: true
        //         border.color: "black"
        //         border.width: 1

        //         ListView {
        //             width: parent.width * 0.3
        //             model: ListModel {
        //                 ListElement { name: "Item 1" }
        //                 ListElement { name: "Item 2" }
        //                 ListElement { name: "Item 3" }
        //                 // Add more items as needed
        //             }

        //             delegate: Item {
        //                 width: listView.width
        //                 height: 50

        //                 Rectangle {
        //                     width: parent.width
        //                     height: 50
        //                     color: "lightblue"

        //                     Text {
        //                         anchors.centerIn: parent
        //                         text: model.name
        //                     }
        //                 }
        //             }
        //         }
        //     }

            // Right Section (ImageViewer)
            // Rectangle {
            //     Layout.preferredWidth: parent.width * 0.7
            //     Layout.fillHeight: true
            //     border.color: "black"
            //     border.width: 1


            // }
        // }


    }


}
