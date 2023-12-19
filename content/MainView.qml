import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls

Rectangle {
    Layout.fillHeight: true
    Layout.fillWidth: true
    color: "transparent"

    RowLayout {
        anchors.fill: parent

        // Left Section (ListView)
        Rectangle {
            Layout.preferredWidth: parent.width * 0.2
            Layout.fillHeight: true
            Layout.margins: 5
            border.color: "black"
            border.width: 1

            ListView {
                id:listView
                anchors.fill: parent
                anchors.top: parent.top
                anchors.left: parent.left
                model: ListModel {

                    // Add more items as needed
                }

                delegate: Item {
                    width: listView.width
                    height: 50

                    Rectangle {
                        width: parent.width
                        height: 50
                        color: "lightblue"

                        Text {
                            anchors.centerIn: parent
                            text: model.name
                        }
                    }
                }

                onSelectedPathChanged: {
                    folderListView.model.append({ path: fileDialogHandler.selectedPath });
                }
            }

            FileDialogHandler {
                id: fileDialogHandler
            }
        }

        // Right Section (ImageViewer)
        Rectangle {
            Layout.preferredWidth: parent.width * 0.75
            Layout.fillHeight: true
            Layout.margins: 5
            border.color: "black"
            border.width: 1


        }
    }
}
