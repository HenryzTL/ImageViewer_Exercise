import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Dialogs


Rectangle {
    Layout.preferredHeight: 50
    Layout.fillWidth: true
    color: "#ffffff"
    property url documentsFolder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)

    RowLayout {
        // anchors.centerIn: parent
        anchors.fill: parent
        Rectangle {
            Layout.preferredWidth: parent.width * 0.2
            Button {
                text: "Open..."
                anchors.verticalCenter: parent.verticalCenter
                onClicked: {
                    fileDialogHandler.open()
                }
            }

            FileDialogHandler {
                    id: fileDialogHandler
                }
        }

        Rectangle {
            Layout.preferredWidth: parent.width * 0.8
            Layout.fillHeight: true

            RowLayout {
                anchors.fill: parent
                spacing: 10

                Item {
                    Layout.preferredWidth: parent.width * 0.2
                    Layout.fillHeight: true

                }

                // Buttons
                Button {
                    text: "Button 1"
                    onClicked: {
                        console.log("Button 1 clicked")
                    }
                }

                Button {
                    text: "Button 2"
                    onClicked: {
                        console.log("Button 2 clicked")
                    }
                }


                Slider {
                    width: parent.width * 0.5
                    from: 0
                    to: 100
                    stepSize: 1
                    value: 50

                    onValueChanged: {
                        console.log("Slider value:", value)
                        sliderText.text = value.toFixed(0)
                    }
                }

                Text {
                    id: sliderText

                    color: "#000000"
                    text: "50" // Initial value
                }

                Item {
                    Layout.preferredWidth: parent.width * 0.2
                    Layout.fillHeight: true

                }
            }
        }

    }



}

