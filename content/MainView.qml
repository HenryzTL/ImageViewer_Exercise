import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls

Item {
    id: _top

    property real imageScale: 1

    readonly property alias images: listView
    readonly property alias image: image

    // readonly property alias imageSourceSize: image.sourceSize
    // readonly property alias imagePaintedSize: Qt.size(image.paintedWidth, image.paintedHeight)

    signal imageLoaded(var ratio)
    signal imageSizeChanged(var ratio)

    RowLayout {
        anchors.fill: parent
        anchors.margins: 5
        spacing: 0

        // Left Section (ListView)
        Rectangle {
            Layout.preferredWidth: parent.width * 0.2
            Layout.fillHeight: true
            color: "#ffffff"

            ListView {
                id: listView
                anchors.fill: parent

                model: ListModel {}

                delegate: MouseArea {
                    width: listView.width
                    height: 30

                    Rectangle {
                        anchors.fill: parent
                        color: listView.currentIndex == index ? "#eeeeee" : "transparent"

                        Text {
                            anchors.fill: parent
                            anchors.centerIn: parent
                            text: model.path
                            elide: Text.ElideLeft
                        }
                    }

                    onClicked: {
                        listView.currentIndex = index
                    }
                }

                onCurrentIndexChanged: {
                    image.source = "file:///" + model.get(currentIndex).path
                }
            }
        }

        // Right Section (ImageViewer)
        Rectangle {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.leftMargin: 5

            color: "white"
            clip: true

            Image {
                id: image

                width: parent.width
                height: parent.height
                anchors.centerIn: parent

                fillMode: Image.PreserveAspectFit
                scale: _top.imageScale

                onStatusChanged: {
                    if (image.status === Image.Ready) {
                        const ratio = image.paintedWidth / image.sourceSize.width
                        imageLoaded(ratio)
                    }
                }
            }

            onWidthChanged: {
                const ratio = image.paintedWidth / image.sourceSize.width
                imageSizeChanged(ratio)
            }

            onHeightChanged: {
                const ratio = image.paintedWidth / image.sourceSize.width
                imageSizeChanged(ratio)
            }
        }
    }
}
