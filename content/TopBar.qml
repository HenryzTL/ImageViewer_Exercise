import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Dialogs

Rectangle {
    id: _top

    color: "#ffffff"

    property real zoomValue: 100
    property real lastSlideValue: 100
    property bool fitMode: false

    signal filesSelected(var fileUrls)
    signal ratioBarValueChanged(var value)

    RowLayout {
        anchors.fill: parent

        Item {
            Layout.preferredWidth: parent.width * 0.2
            Layout.fillHeight: true

            Rectangle {
                width: 50
                height: parent.height * 0.5
                anchors.verticalCenter: parent.verticalCenter

                color: "white"
                border.color: "#000000"
                radius: 5

                Text {
                    anchors.centerIn: parent
                    text: "Open..."
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        fileDialogHandler.open()
                    }
                }
            }

            FileDialog {
                id: fileDialogHandler
                fileMode: FileDialog.OpenFiles
                nameFilters: ["Image files (*.jpg *jpeg *.png)"]

                onAccepted: {
                    let imageUrls = []
                    for(let url of fileDialogHandler.selectedFiles){
                        const path = url.toString().replace(/^(file:\/{3})/,"")
                        imageUrls.push(path)
                    }

                    _top.filesSelected(imageUrls)
                }

                onRejected: {
                    console.log("Dialog rejected")
                }
            }
        }

        Item {
            Layout.preferredWidth: parent.width * 0.8
            Layout.fillHeight: true
            clip: true

            Row {
                height: parent.height
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 10

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    text: "Zoom:"
                }

                Rectangle {
                    width: 50
                    height: parent.height * 0.5
                    anchors.verticalCenter: parent.verticalCenter

                    color: _top.fitMode ? "#949494" : "#ffffff"
                    border.color: "#000000"
                    radius: 5

                    Text {
                        anchors.centerIn: parent
                        text: "Fit"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if(_top.fitMode){
                                _top.fitMode = false
                                _top.zoomValue = _top.lastSlideValue
                                ratioBarValueChanged(_top.zoomValue / 100)
                            }else{
                                _top.fitMode = true
                            }

                        }
                    }
                }

                Slider {
                    id: ratioBar
                    width: parent.width * 0.5
                    anchors.verticalCenter: parent.verticalCenter

                    from: 0.5
                    to: 200
                    stepSize: 0.1
                    value: _top.zoomValue

                    onMoved: {
                        // sliderText.text = value.toFixed(0)+"%"
                        ratioBarValueChanged(value / 100)
                        _top.fitMode = false
                        _top.lastSlideValue = value
                    }

                    onValueChanged: {
                        _top.zoomValue = value
                        sliderText.text = value.toFixed(1)+"%"
                    }
                }

                Text {
                    id: sliderText
                    width: 0.2 * parent.width
                    anchors.verticalCenter: parent.verticalCenter

                    color: "#000000"
                }
            }
        }
    }
}
