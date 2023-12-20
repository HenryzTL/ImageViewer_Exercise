import QtQuick
import QtQuick.Layouts
import "./content"

Rectangle {
    id: _top
    width: 1280
    height: 960
    color: "#999999"

    function scaleToFit() {
        const displayedHeight = mainView.image.sourceSize.height * topbar.zoomValue / 100
        const targetScaleH = displayedHeight / mainView.image.height
        const displayedWidth = mainView.image.sourceSize.width * topbar.zoomValue / 100
        const targetScaleW = displayedWidth / mainView.image.width

        mainView.imageScale = Math.max(targetScaleH, targetScaleW)
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        TopBar {
            id: topbar

            Layout.preferredHeight: 50
            Layout.fillWidth: true
            Layout.leftMargin: 5
            Layout.rightMargin: 5
            Layout.topMargin: 5

            onFilesSelected: function(fileUrls) {
                const showIndex = mainView.images.model.count
                for(let url in fileUrls)
                    mainView.images.model.append({ "path": fileUrls[url] })

                mainView.images.currentIndex = showIndex
            }

            onRatioBarValueChanged: function(value) {
                _top.scaleToFit()
            }

            onFitModeChanged: {
                if (fitMode) {
                    mainView.imageScale = 1
                    const ratio = mainView.image.paintedWidth / mainView.image.sourceSize.width
                    topbar.zoomValue = 100 * ratio
                }
            }
        }

        MainView {
            id: mainView

            Layout.fillHeight: true
            Layout.fillWidth: true

            onImageLoaded: function(ratio) {
                topbar.zoomValue = 100 * ratio
                topbar.fitMode = true
            }

            onImageSizeChanged: function(ratio) {
                if (!topbar.fitMode){
                    _top.scaleToFit()
                } else {
                    topbar.zoomValue = 100 * ratio
                    mainView.imageScale = 1
                }
            }
        }
    }
}
