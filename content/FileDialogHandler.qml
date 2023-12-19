// FileDialogHandler.qml

import QtQuick 2.15
import QtQuick.Dialogs

Item {
    property string selectedPath: ""

    FileDialog {
        id: fileDialog
        currentFolder: documentsFolder

        onAccepted: {
            selectedPath = fileDialog.fileUrl.toString();
        }

        onRejected: {
            console.log("Dialog rejected")
        }
    }
}
