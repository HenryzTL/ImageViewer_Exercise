import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls


Rectangle {
    Layout.preferredHeight: 50
    Layout.fillWidth: true
    color: "lightblue"

    RowLayout {
        // anchors.centerIn: parent
        anchors.fill: parent
        Rectangle {
            Layout.preferredWidth: parent.width * 0.3
            Button {
                text: "Open..."
                anchors.verticalCenter: parent.verticalCenter
                onClicked: {
                    console.log("Left button clicked")
                }
            }
        }

        Rectangle {
            Layout.preferredWidth: parent.width * 0.7
            Layout.fillHeight: true
            border.color: "black"
            border.width: 1
        }

    }


    // Right Half with Buttons and Slider
    // Rectangle {
    //     Layout.preferredWidth: parent.width * 0.7
    //     Layout.fillHeight: true
    //     border.color: "black"
    //     border.width: 1

    //     // ColumnLayout {
    //     //     anchors.fill: parent
    //     //     spacing: 10

    //     //     // Buttons
    //     //     Button {
    //     //         text: "Button 1"
    //     //         onClicked: {
    //     //             console.log("Button 1 clicked")
    //     //         }
    //     //     }

    //     //     Button {
    //     //         text: "Button 2"
    //     //         onClicked: {
    //     //             console.log("Button 2 clicked")
    //     //         }
    //     //     }


    //     //     Slider {
    //     //         width: parent.width * 0.5
    //     //         from: 0
    //     //         to: 100
    //     //         stepSize: 1
    //     //         value: 50

    //     //         onValueChanged: {
    //     //             console.log("Slider value:", value)
    //     //             sliderText.text = value.toFixed(0)
    //     //         }
    //     //     }

    //     //     Text {
    //     //         id: sliderText
    //     //         color: "#000000"
    //     //         text: "50" // Initial value
    //     //     }

    //     // }
    // }

}

