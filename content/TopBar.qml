import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Dialogs

Rectangle {
    id: topBar
    Layout.preferredHeight: 50
    Layout.fillWidth: true
    Layout.margins: 2
    Layout.alignment: Qt.AlignCenter
    color: "#ffffff"

    property alias ratioBar: ratioBar
    property alias fitbutton: fitButton

    signal filesSelected(var fileUrlsStr, var fileUrls)
    signal fileSelected(var fileUrl)
    signal ratioBarValueChanged(var value)
    signal fitButtonOn()
    signal fitButtonOff()

    RowLayout {
        anchors.fill: parent

        Rectangle {
            Layout.preferredWidth: parent.width * 0.2
            Layout.fillHeight: true

            Item {
                width: 50
                height: parent.height * 0.5
                anchors.verticalCenter: parent.verticalCenter

                Rectangle {
                    anchors.fill: parent
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
            }

            FileDialog {
                id: fileDialogHandler
                fileMode: FileDialog.OpenFiles
                nameFilters: ["Image files (*.jpg *.png)"]

                onAccepted: {
                    var imageslistStr = []
                    var imageslistUrl = []
                    for(var url of fileDialogHandler.selectedFiles){
                        var path = url.toString()
                        path = path.replace(/^(file:\/{3})/,"")
                        imageslistStr.push(path)
                        imageslistUrl.push(url)
                    }
                    if(imageslistStr.length > 1){
                        topBar.filesSelected(imageslistStr, imageslistUrl)
                    }else if(imageslistStr.length == 1){
                        topBar.fileSelected(imageslistUrl[0])
                    }
                }

                onRejected: {
                    console.log("Dialog rejected")
                }
            }
        }

        Rectangle {
            Layout.preferredWidth: parent.width * 0.8
            Layout.fillHeight: true

            RowLayout {
                anchors.fill: parent
                spacing: 10

                Item {
                    Layout.preferredWidth: parent.width * 0.4
                    Layout.fillHeight: true
                }

                Text {
                    text: "Zoom:"
                }

                Item {

                    Layout.preferredWidth: 50
                    Layout.preferredHeight: parent.height * 0.5

                    Rectangle {
                        id: fitButton
                        anchors.fill: parent
                        color: "white"
                        border.color: "#000000"
                        radius: 5

                        Text {
                            anchors.centerIn: parent
                            text: "Fit"
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                fitButtonOn()
                            }
                        }
                    }
                }

                Slider {
                    id: ratioBar
                    width: parent.width * 0.5
                    from: 1
                    to: 200
                    stepSize: 1
                    value: 50

                    onMoved: {
                        // sliderText.text = value.toFixed(0)+"%"
                        ratioBarValueChanged(value / 100)
                        fitButtonOff()
                    }

                    onValueChanged: {
                        sliderText.text = value.toFixed(0)+"%"
                    }
                }

                Text {
                    id: sliderText
                    Layout.preferredWidth: 0.2 * parent.width

                    color: "#000000"
                }

                Item {
                    Layout.preferredWidth: parent.width * 0.2
                    Layout.fillHeight: true
                }
            }
        }
    }
}
