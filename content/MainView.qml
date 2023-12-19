import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls

Rectangle {
    Layout.fillHeight: true
    Layout.fillWidth: true
    Layout.margins: 0.5
    color: "transparent"

    property int scaleReference // 1 Height or 0 Width
    property alias images : listView
    property alias image: image
    signal imageLoaded(var ratio)
    signal imageRatioChanged(var ratio)

    RowLayout {
        anchors.fill: parent

        // Left Section (ListView)
        Rectangle {
            Layout.alignment: Qt.AlignCenter
            Layout.preferredWidth: parent.width * 0.2
            Layout.fillHeight: true
            Layout.margins: 0.5
            ListView {
                id: listView
                anchors.fill: parent
                anchors.top: parent.top
                anchors.left: parent.left
                model: ListModel {
                }

                delegate: MouseArea {
                    width: listView.width
                    height: 30

                    Rectangle {
                        anchors.fill: parent
                        color: listView.currentIndex == index ? "#eeeeee" : "transparent"

                        Text {
                            anchors.fill: parent
                            anchors.centerIn: parent
                            text: model.string
                            elide: Text.ElideLeft
                        }
                    }

                    onClicked: {
                        //image.source = model.path
                        listView.currentIndex = index
                    }
                }

                onCurrentIndexChanged: {
                    image.source = model.get(currentIndex).path
                }
            }

        }

        // Right Section (ImageViewer)
        Rectangle {
            Layout.alignment: Qt.AlignCenter
            Layout.preferredWidth: parent.width * 0.75
            Layout.fillHeight: true
            Layout.margins: 0.5
            clip: true

            RowLayout {
                anchors.fill: parent
                anchors.centerIn: parent
                Image {
                    id: image

                    Layout.alignment: Qt.AlignCenter
                    Layout.preferredWidth: parent.width
                    Layout.preferredHeight: parent.height
                    fillMode: Image.PreserveAspectFit

                    onStatusChanged: {
                        if (image.status === Image.Ready) {
                            var ratio = image.paintedWidth / image.sourceSize.width
                            imageLoaded(ratio)

                            console.log("Original Width:", image.sourceSize.width);
                            console.log("Original Height:", image.sourceSize.height);

                            // // Access the displayed size
                            // console.log("Displayed Width:", image.paintedWidth);
                            // console.log("Displayed Height:", image.paintedHeight);

                            // // Access the displayed size
                            // console.log("frame Width:", parent.width);
                            // console.log("frame Height:", parent.height);

                            // var marginX = parent.x - image.contentX;
                            // var marginY = parent.y - image.contentY;

                            // console.log("MarginX:", marginX);
                            // console.log("MarginY:", marginY);
                        }
                    }
                }
            }

            onWidthChanged: {
                var ratio = image.paintedWidth / image.sourceSize.width
                imageRatioChanged(ratio)
            }
        }


    }
}
