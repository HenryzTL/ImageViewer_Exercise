
// FileDialogHandler.qml
import QtQuick 2.15
import QtQuick.Dialogs

Item {
    id: fileSelectedHandler
    signal fileSelected(string selectedPath)

    FileDialog {
        id: fileDialog
        currentFolder: documentsFolder

        onAccepted: {
            fileSelectedHandler.fileSelected(fileDialog.fileUrl.toString())
        }

        onRejected: {
            console.log("Dialog rejected")
        }
    }
}
