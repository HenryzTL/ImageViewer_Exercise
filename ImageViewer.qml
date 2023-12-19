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
        }

        MainView {
            id: main
        }
    }




}
