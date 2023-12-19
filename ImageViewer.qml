import QtQuick
import QtQuick.Layouts
import "./content"

Rectangle {
    id: mainRect
    width: 1280
    height: 960
    visible: true
    color: "#999999"

    ColumnLayout {
        anchors.fill: parent

        TopBar {
            id: topbar

            onFilesSelected: function(fileUrlsStr, fileUrls) {
                mainView.images.model.clear()
                for(var url in fileUrls)
                    mainView.images.model.append({"path": fileUrls[url], "string" : fileUrlsStr[url]})
            }

            onFileSelected: function(fileUrl) {
                mainView.images.model.clear()
                mainView.image.source = fileUrl
            }

            onRatioBarValueChanged: function(value) {
                var targetScale
                if(mainView.scaleReference == 1){
                    var displayedHeight = mainView.image.sourceSize.height * value
                    targetScale = displayedHeight / mainView.image.height
                }else{
                    var displayedWidth = mainView.image.sourceSize.width * value
                    targetScale = displayedWidth / mainView.image.width
                }

                mainView.image.scale = targetScale

                // console.log("Original Width:", mainView.image.width);
                // console.log("Original Height:", mainView.image.height);

                // // Access the displayed size
                // console.log("Displayed Width:", mainView.image.paintedWidth);
                // console.log("Displayed Height:", mainView.image.paintedHeight);
            }

            onFitButtonOn: {
                mainView.image.scale = 1
                topbar.fitbutton.color = "#949494"
                var ratio = mainView.image.paintedWidth / mainView.image.sourceSize.width
                mainView.imageRatioChanged(ratio)

                if(mainView.image.width == mainView.image.paintedWidth)
                    mainView.scaleReference = 0
                if(mainView.image.height == mainView.image.paintedHeight)
                    mainView.scaleReference = 1

            }

            onFitButtonOff: {
                topbar.fitbutton.color = "#ffffff"
            }
        }

        MainView {
            id: mainView
            onImageLoaded: function(ratio) {
                topbar.ratioBar.value = 100 * ratio
                topbar.fitButtonOn()
                //topbar.fitbutton.highlighted = true
            }

            onImageRatioChanged: function(ratio) {
                topbar.ratioBar.value = 100 * ratio
                mainView.image.scale = 1
                topbar.fitbutton.color = "#949494"
            }
        }
    }




}
