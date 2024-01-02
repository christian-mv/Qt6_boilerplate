import QtQuick
import QtQuick.Window

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Hello World")

    // Add a Text element to display Qt version
       Text {
           id: versionText
           text: "Qt Version: " + QT_VERSION_STR   // This line sets the text to the Qt version
           anchors.centerIn: parent // This line centers the text element within the window
       }
}
